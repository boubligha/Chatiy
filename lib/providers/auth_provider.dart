import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

enum AuthStatus {
  NotAuthenticated,
  Authenticating,
  Authenticated,
  UserNotFound,
  Error
}

class AuthProvider extends ChangeNotifier {
  AuthStatus status = AuthStatus.NotAuthenticated;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? user;

  static final AuthProvider instance = AuthProvider._internal();

  AuthProvider._internal();

  factory AuthProvider() {
    return instance;
  }

  Future<void> loginUserWithEmailAndPassword(String email, String password) async {
    status = AuthStatus.Authenticating;
    notifyListeners();

    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      user = result.user;
      status = AuthStatus.Authenticated;
      notifyListeners();
      print("User logged in");
      // Naviguer vers la page d'accueil
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        status = AuthStatus.UserNotFound;
      } else {
        status = AuthStatus.Error;
      }
      notifyListeners();
      print("Error during login: ${e.message}");
    } catch (e) {
      status = AuthStatus.Error;
      notifyListeners();
      print("Unexpected error: $e");
    }
  }
}