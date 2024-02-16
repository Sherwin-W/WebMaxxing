import 'dart:io'; // Import Dart's IO library for file operations.
import 'package:flutter/material.dart'; // Import Flutter's material design library.
import 'package:firebase_storage/firebase_storage.dart'; // Import Firebase Storage library.

// Function to upload an image file to Firebase Storage.
Future<void> uploadImage(File image, BuildContext context) async {
  try {
    // Generate a unique file name for the image.
    String fileName = 'images/${DateTime.now().millisecondsSinceEpoch}.jpg';
    FirebaseStorage storage = FirebaseStorage.instance; // Get an instance of FirebaseStorage.
    Reference ref = storage.ref().child(fileName); // Create a reference in Firebase Storage.
    UploadTask uploadTask = ref.putFile(image); // Start the upload task.
    await uploadTask; // Wait for the upload to complete.
    // Show a success message.
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Image uploaded successfully')));
  } catch (e) {
    // Show an error message if something goes wrong.
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
  }
}
