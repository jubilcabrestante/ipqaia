import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ipqaia/core/domain/i_user_repository.dart';
import 'package:ipqaia/core/repository/user_model/user_vm.dart';
import 'package:ipqaia/features/main/accounts/models/account_creation_vm.dart';

class UserRepository implements IUserRepository {
  final FirebaseAuth _firebaseAuth;
  final FirebaseFirestore _firestore;

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

      final docRef = _firestore.collection('admin').doc(authUser.uid);

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
      // 1. Await the sign-in operation
      final userCredential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      // 2. Get the authenticated user
      final user = userCredential.user;
      if (user == null) {
        throw Exception("User not found after sign-in");
      }

      // 3. Fetch additional user data from Firestore
      final doc = await _firestore.collection('admin').doc(user.uid).get();
      if (!doc.exists) {
        throw Exception("User data not found in Firestore");
      }

      return UserVm.fromJson(doc.data()!);
    } catch (e) {
      log("Sign-in failed: ${e.toString()}");
      rethrow;
    }
  }

  @override
  Future<void> signOut() async {
    _firebaseAuth.signOut();
  }
}
