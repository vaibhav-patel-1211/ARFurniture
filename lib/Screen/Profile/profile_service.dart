import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class ProfileService extends GetxController {
  static ProfileService get instance => Get.find();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Update username
  Future<void> updateUsername(String newName) async {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        await _firestore.collection('users').doc(user.uid).update({
          'name': newName,
        });
        Get.snackbar('Success', 'Username updated successfully');
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to update username: ${e.toString()}');
    }
  }

  // Update password
  Future<void> updatePassword(
      String currentPassword, String newPassword) async {
    try {
      final user = _auth.currentUser;
      if (user != null && user.email != null) {
        // Re-authenticate user before password change
        AuthCredential credential = EmailAuthProvider.credential(
          email: user.email!,
          password: currentPassword,
        );
        await user.reauthenticateWithCredential(credential);

        // Update password
        await user.updatePassword(newPassword);
        Get.snackbar('Success', 'Password updated successfully');
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to update password: ${e.toString()}');
    }
  }

  // Update location
  Future<void> updateLocation(String newLocation) async {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        await _firestore.collection('users').doc(user.uid).update({
          'location': newLocation,
        });
        Get.snackbar('Success', 'Location updated successfully');
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to update location: ${e.toString()}');
    }
  }

  // Update profile image
  Future<void> updateProfileImage(String imageUrl) async {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        await _firestore.collection('users').doc(user.uid).update({
          'profileImage': imageUrl,
        });
        Get.snackbar('Success', 'Profile image updated successfully');
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to update profile image: ${e.toString()}');
    }
  }

  // Get user data stream
  Stream<DocumentSnapshot> getUserDataStream() {
    final user = _auth.currentUser;
    if (user != null) {
      return _firestore.collection('users').doc(user.uid).snapshots();
    }
    throw Exception('No user logged in');
  }
}
