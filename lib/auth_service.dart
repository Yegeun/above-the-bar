import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'models/user_model.dart';

class AuthService {
  final firebase_auth.FirebaseAuth _firebaseAuth;

  AuthService({
    firebase_auth.FirebaseAuth? firebaseAuth,
  }) : _firebaseAuth = firebaseAuth ?? firebase_auth.FirebaseAuth.instance;

  Stream<UserModel> get user {
    //convert firebase user to user model
    return _firebaseAuth.authStateChanges().map((firebaseUser) {
      final user = firebaseUser == null ? UserModel.empty : firebaseUser.toUser;
      return user;
    });
  }

  UserModel get currentUser {
    if (_firebaseAuth.currentUser == null) return UserModel.empty;
    return _firebaseAuth.currentUser!.toUser;
  }

  Future<void> signup({
    required String email,
    required String password,
  }) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } catch (_) {
      throw Exception();
    }
  }

  Future<void> loginWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } catch (_) {
      throw Exception("Login failed");
    }
  }

  Future<void> logout() async {
    try {
      await _firebaseAuth.signOut();
    } catch (_) {
      throw Exception("Logout failed");
    }
  }
}

extension on firebase_auth.User {
  UserModel get toUser {
    return UserModel(id: uid, email: email, fullName: displayName);
  }
}
