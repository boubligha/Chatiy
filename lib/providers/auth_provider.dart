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

  AuthProvider();

  Future<void> loginUserWithEmailAndPassword(String email, String password) async {
    status = AuthStatus.Authenticating;
    notifyListeners();

    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      user = result.user;
      status = AuthStatus.Authenticated;
      notifyListeners();
      print("User logged in");
      // Navigate to the home page or call a callback
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        status = AuthStatus.UserNotFound;
      } else if (e.code == 'wrong-password') {
        status = AuthStatus.Error;
        print("Wrong password provided for that user.");
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

  Future<void> signOut() async {
    await _auth.signOut();
    user = null;
    status = AuthStatus.NotAuthenticated;
    notifyListeners();
    print("User signed out");
  }

  // Additional methods for sign-up, password reset, etc.
}