

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

class ProfileRemoteDataSource {
  final FirebaseStorage _storage;
  final FirebaseFirestore _firestore;

  ProfileRemoteDataSource({
    FirebaseStorage? storage,
    FirebaseFirestore? firestore,
  }) : _storage = storage ?? FirebaseStorage.instance,
       _firestore = firestore ?? FirebaseFirestore.instance;

  Future<String> uploadProfileImage(XFile image) async {
    try {
      // Create a reference to the location where the image will be stored in Firebase Storage
      final storageRef = _storage.ref().child('profile_images/${image.name}');

      // Upload the image file to Firebase Storage
      final uploadTask = await storageRef.putFile(File(image.path));

      // Get the download URL of the uploaded image
      final downloadUrl = await uploadTask.ref.getDownloadURL();

      return downloadUrl;
    } catch (e) {
      // Handle any errors that may occur during the upload process
      print('Error uploading profile image: $e');
      throw e; // Rethrow the error to be handled by the caller
    }
  }

  Future<void> updateProfileImage(String imageUrl) async {
    try {
      // Update the user's profile image URL in Firestore
      final userDocRef = _firestore.collection('users').doc('user_id'); // Replace 'user_id' with the actual user ID
      await userDocRef.update({'profileImageUrl': imageUrl});
    } catch (e) {
      // Handle any errors that may occur during the update process
      print('Error updating profile image URL in Firestore: $e');
      throw e; // Rethrow the error to be handled by the caller
    }
  }


  Future<String?> getProfile() async {
    try {
      // Retrieve the user's profile data from Firestore
      final userDocRef = _firestore.collection('users').doc('user_id'); // Replace 'user_id' with the actual user ID
      final userDocSnapshot = await userDocRef.get();

      if (userDocSnapshot.exists) {
        final profileData = userDocSnapshot.data();
        return profileData?['profileImageUrl'] as String?;
      } else {
        print('User document does not exist.');
        return null;
      }
    } catch (e) {
      // Handle any errors that may occur during the retrieval process
      print('Error retrieving profile data from Firestore: $e');
      throw e; // Rethrow the error to be handled by the caller
    }
  }
}
