import 'dart:io'; // Import Dart's IO library to work with file objects.
import 'package:flutter/material.dart'; // Import Flutter material design library.
import 'package:image_picker/image_picker.dart'; // Import the image_picker library.
import 'upload_image.dart'; // Import the upload_image.dart file for uploading functionality.

class AddImage extends StatefulWidget {
  @override
  _AddImageState createState() => _AddImageState(); // Create state for the widget.
}

class _AddImageState extends State<AddImage> {
  File? _image; // Variable to hold the selected or taken image.

  // Function to handle image picking from gallery or camera.
  Future pickImage(ImageSource source) async {
    final pickedFile = await ImagePicker().pickImage(source: source); // Open image picker dialog.

    // Check if an image was selected or taken.
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path); // Update _image with the selected/taken image.
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // Build UI elements.
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Image'), // App bar title.
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _image != null ? Image.file(_image!) : Text('No image selected.'), // Display the selected/taken image or a text message.
            ElevatedButton(
              onPressed: () => pickImage(ImageSource.camera), // Button to take picture.
              child: Text('Take Picture'),
            ),
            ElevatedButton(
              onPressed: () => pickImage(ImageSource.gallery), // Button to pick from gallery.
              child: Text('Pick from Gallery'),
            ),
            if (_image != null) // Show upload button only if an image is selected/taken.
              ElevatedButton(
                onPressed: () => uploadImage(_image!, context), // Button to upload the image.
                child: Text('Upload Image'),
              ),
          ],
        ),
      ),
    );
  }
}
