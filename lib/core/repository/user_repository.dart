import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ipqaia/core/domain/i_user_repository.dart';
import 'package:ipqaia/core/repository/user_model/user_dto.dart';

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
      UserDto user, String password, String adminPassword) async {
    UserCredential? userCredential;

    try {
      // ✅ Store the current admin user before creating a new account
      // User? currentUser = _firebaseAuth.currentUser;
      // String? currentEmail = currentUser!.email;

      // ✅ Create user in Firebase Auth first
      userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: user.email,
        password: password,
      );

      if (userCredential.user == null) {
        throw Exception("User creation failed.");
      }

      String newUserId = userCredential.user!.uid;
      final newUser = user.copyWith(uid: newUserId);

      // // ✅ Sign back in with the original admin account
      // if (currentEmail != null) {
      //   await _firebaseAuth.signInWithEmailAndPassword(
      //     email: currentEmail,
      //     password: adminPassword,
      //   );
      // } else {
      //   log("Failed to sign back in as admin. Please re-authenticate.");
      // }

      return await saveUser(newUser);
    } catch (e) {
      log("Failed to create user: ${e.toString()}");
      rethrow;
    }
  }

  @override
  Future<void> saveUser(UserDto user) async {
    try {
      await _firestore.collection('admin').doc(user.uid).set(user.toJson());
    } catch (e) {
      log("Failed to save user: ${e.toString()}");
      rethrow;
    }
  }

  @override
  Future<void> signInWithEmailAndPassword(String email, String password) async {
    try {
      _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
    } catch (e) {
      throw e.toString();
    }
  }

  @override
  Future<void> signOut() async {
    _firebaseAuth.signOut();
  }
}
