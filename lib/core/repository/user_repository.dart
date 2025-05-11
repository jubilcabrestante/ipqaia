import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ipqaia/core/domain/i_user_repository.dart';
import 'package:ipqaia/core/repository/user_model/user_vm.dart';
import 'package:ipqaia/features/main/accounts/models/account_creation_vm.dart';
import 'package:ipqaia/talker_service.dart';

class UserRepository implements IUserRepository {
  final FirebaseAuth _firebaseAuth;
  final FirebaseFirestore _firestore;
  final String adminCollection = 'admin';

  UserRepository({
    FirebaseAuth? firebaseAuth,
    FirebaseFirestore? firestore,
  })  : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance,
        _firestore = firestore ?? FirebaseFirestore.instance;

  @override
  Future<void> createUserWithEmailAndPassword(
      AccountVm user, String password) async {
    try {
      // 1. Create Firebase Auth user first
      final userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: user.email,
        password: password,
      );

      final authUser = userCredential.user;
      if (authUser == null) throw Exception("User creation failed.");

      final docRef = _firestore.collection(adminCollection).doc(authUser.uid);

      final newUser = AccountVm(
        uid: authUser.uid,
        role: user.role,
        name: user.name,
        email: user.email,
        age: user.age,
        gender: user.gender,
      );

      await docRef.set(newUser.toJson());
    } catch (e) {
      log("Failed to create user: ${e.toString()}");
      rethrow;
    }
  }

  @override
  Future<UserVm> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      final userCredential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      final user = userCredential.user;
      if (user == null) {
        throw Exception("User not found after sign-in");
      }

      final doc =
          await _firestore.collection(adminCollection).doc(user.uid).get();
      if (!doc.exists) {
        throw Exception("User data not found in Firestore");
      }
      TalkerService.talker.debug(doc.data());

      return UserVm.fromJson(doc.data()!);
    } catch (e) {
      log("Sign-in failed: ${e.toString()}");
      rethrow;
    }
  }

  @override
  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  @override
  Future<List<AccountVm>> getUserList() async {
    try {
      final snapshot = await _firestore.collection(adminCollection).get();
      final List<AccountVm> userList =
          snapshot.docs.map((doc) => AccountVm.fromJson(doc.data())).toList();

      return userList;
    } catch (e) {
      log("Failed to fetch user list: ${e.toString()}");
      rethrow;
    }
  }

  @override
  Future<void> deleteUser(String uid) async {
    try {
      await _firestore.collection(adminCollection).doc(uid).delete();
    } catch (e) {
      log("Failed to delete user: ${e.toString()}");
      rethrow;
    }
  }
}
