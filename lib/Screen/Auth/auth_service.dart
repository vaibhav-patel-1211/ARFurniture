import 'package:ar_furniture/Screen/Auth/login_screen.dart';
import 'package:ar_furniture/Screen/Home/home_screen.dart';
import 'package:ar_furniture/Screen/entry_point.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

// User model for Firestore
class UserModel {
  String uid;
  String name;
  String email;

  UserModel({required this.uid, required this.name, required this.email});

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'name': name,
      'email': email,
    };
  }
}

class AuthService extends GetxController {
  static AuthService get instance => Get.find();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Login method
  Future<void> login(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      Get.snackbar('Success', 'Logged in successfully');
      Get.offAll(() => const EntryPoint()); // Navigate to Home Screen
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }

  // Sign-up method with Firestore user data saving
  Future<void> signUp(String name, String email, String password) async {
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email.trim().toLowerCase(), // Ensure proper formatting
        password: password,
      );

      String uid = userCredential.user!.uid;

      // Save user details to Firestore
      UserModel newUser = UserModel(uid: uid, name: name, email: email);
      await _firestore.collection('users').doc(uid).set(newUser.toMap());

      Get.snackbar('Success', 'Account created and details saved');
      Get.offAll(() => const EntryPoint()); // Navigate to Home Screen
    } on FirebaseAuthException catch (e) {
      // Handle specific Firebase Auth errors
      String errorMessage;
      switch (e.code) {
        case 'invalid-email':
          errorMessage = 'The email address is badly formatted.';
          break;
        case 'email-already-in-use':
          errorMessage =
              'The email address is already in use by another account.';
          break;
        case 'weak-password':
          errorMessage = 'The password provided is too weak.';
          break;
        default:
          errorMessage = 'An unexpected error occurred. Please try again.';
      }
      Get.snackbar('Signup Error', errorMessage);
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }

  // Sign out method
  Future<void> signOut() async {
    try {
      await _auth.signOut(); // First sign out the user
      Get.snackbar('Success', 'Logged out successfully'); // Then show snackbar
      Get.offAll(() => const LoginScreen()); // Navigate to Login Screen
    } catch (e) {
      Get.snackbar('Error', 'Logout failed: ${e.toString()}');
    }
  }
}
