import 'dart:io';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:first_flutter_app/widgets/photo_view_page.dart';
import 'package:first_flutter_app/widgets/load_image.dart';
import 'package:shared_preferences/shared_preferences.dart';


class LooksMaxxingWidget extends StatefulWidget {
  const LooksMaxxingWidget({super.key});

  @override
  _LooksMaxxingWidgetState createState() => _LooksMaxxingWidgetState();
}

class _LooksMaxxingWidgetState extends State<LooksMaxxingWidget> {

  List<String> photos = [
    'https://m.media-amazon.com/images/I/71IeYNcBYdL._SX679_.jpg',
  ];

  @override
  void initState() {
    super.initState();
    _loadPhotos();
  }

  Future<void> _loadPhotos() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      photos = prefs.getStringList('savedPhotos') ?? photos;
    });
  }
  Future<void> _savePhotos() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('savedPhotos', photos);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("LooksMaxxing"),
        actions: <Widget>[
          //add new image from load_image.dart
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () async {
              final String? newImagePath = await Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const AddImage()),
              );
              if (newImagePath != null) {
                setState(() {
                  photos.add(newImagePath); // Add the new image to the photos list
                  _savePhotos(); // Save the updated list
                });
              }
            },
          ),
          //delete the latest image
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () {
              if (photos.isNotEmpty) {
                setState(() {
                  photos.removeLast(); // Remove the last image from the list
                  _savePhotos(); // Update the saved list in SharedPreferences
                });
              }
            },
          ),
        ],
      ),
      body: GridView.builder(
        physics: const BouncingScrollPhysics(
          parent: AlwaysScrollableScrollPhysics(),
        ),
        padding: const EdgeInsets.all(1),
        itemCount: photos.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
        ),
        itemBuilder: ((context, index) {
          //
          final uri = Uri.tryParse(photos[index]);
          final isNetworkImage = uri != null && uri.scheme.startsWith('http');
          //
          return Container(
            padding: const EdgeInsets.all(0.5),
            child: InkWell(
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => PhotoViewPage(photos: photos, index: index),
                ),
              ),
              child: Hero(
                tag: photos[index],
                //
                child: isNetworkImage
                    ? CachedNetworkImage(
                        imageUrl: photos[index],
                        fit: BoxFit.cover,
                        placeholder: (context, url) => Container(color: Colors.grey),
                        errorWidget: (context, url, error) => Container(
                          color: Colors.red.shade400,
                        ),
                      )
                      : Image.file(
                        File(photos[index]),
                        fit: BoxFit.cover,
                      ),
                //
              ),
            ),
          );
        }),
      ),
    );
  }
}


//reference : https://github.com/Rapid-Technology/flutter_gallery
//looksmaxxing