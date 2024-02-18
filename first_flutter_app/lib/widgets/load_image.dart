import 'dart:io'; // Import Dart's IO library to work with file objects.
import 'package:flutter/material.dart'; // Import Flutter material design library.
import 'package:image_picker/image_picker.dart'; // Import the image_picker library.
import 'package:path_provider/path_provider.dart'; 
import 'package:path/path.dart' as path;

class AddImage extends StatefulWidget {
  const AddImage({super.key});

  @override
  _AddImageState createState() => _AddImageState();
}

class _AddImageState extends State<AddImage> {
  final ImagePicker _picker = ImagePicker();
  final double padding = 20.0;
  
  XFile? pickedFile;

  @override
  void initState() {
    super.initState();
    loadImage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Image Picker"),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: padding),
        child: ListView(
          children: [
            SizedBox(height: padding,),
            ElevatedButton(onPressed: pickImage, child: const Text("Pick Image")),
            SizedBox(height: padding/2,),
            ElevatedButton(onPressed: capturePhoto, child: const Text("Take Photo")),
            SizedBox(height: padding/2,),
            pickedFile!=null? Image.file(File(pickedFile!.path)) : Container(),
            pickedFile!=null? SizedBox(height: padding,) : Container(),
            
            ElevatedButton(onPressed: ok, child: const Text("ok")),
            SizedBox(height: padding/2,),
          ],
        ),
      ),
    );
  }

  //ok
  void ok() async {
    if (pickedFile != null) {
    Navigator.pop(context, pickedFile!.path); // Return the path of the picked image
    }
  }
  
  /// Pick an image
  void pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        pickedFile = image;
      });

      saveImage(image);

    }
  }

  /// Capture a photo
  void capturePhoto() async {
    final XFile? photo = await _picker.pickImage(source: ImageSource.camera);
    if (photo != null) {
      setState(() {
        pickedFile = photo;
      });

      saveImage(photo);

    }
  }

  //save image
  void saveImage(XFile img) async {
    // Step 3: Get directory where we can duplicate selected file.
    final String directoryPath = (await getApplicationDocumentsDirectory()).path;

    File convertedImg = File(img.path);

    // Step 4: Copy the file to a application document directory.
    // Extract the filename from the path.
    final String fileName = path.basename(convertedImg.path);
    final File localImage = await convertedImg.copy('$directoryPath/$fileName');
    print("Saved image under: $directoryPath/$fileName");
  }

  void loadImage() async {
    final directory = await getApplicationDocumentsDirectory();
    final directoryPath = directory.path;
    final dir = Directory(directoryPath);
    List<FileSystemEntity> files = dir.listSync(); // List all files in the directory.

    // Filter out all files that are not images or according to a naming convention if applicable.
    var imageFiles = files.where((file) => path.extension(file.path).toLowerCase() == '.jpg' || path.extension(file.path).toLowerCase() == '.png');

    // Assuming we want the most recently created file if there are multiple.
    FileSystemEntity? newestImage;
    DateTime? newestDate;

    for (var file in imageFiles) {
      final fileStat = await file.stat();
      if (newestDate == null || fileStat.changed.isAfter(newestDate)) {
        newestImage = file;
        newestDate = fileStat.changed;
      }
    }

    if (newestImage != null) {
      print("Image exists. Loading it...");
      setState(() {
        pickedFile = XFile(newestImage!.path);
      });
    } else {
      print("No image found");
    }
  }

}

//reference : https://github.com/eclectifyTutorials/YT_Tutorial_Pkg_Image_Picker/blob/main/main.dart
//reference : https://github.com/eclectifyTutorials/YT_Tutorial_Pkg_Image_Picker

//path_provider is used to save the image local database
//possible way to make it better :  Isar DB and Hive to save 
//load image