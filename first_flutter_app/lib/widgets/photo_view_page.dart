import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

class PhotoViewPage extends StatelessWidget {
  final List<String> photos;
  final int index;

  const PhotoViewPage({
    super.key,
    required this.photos,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(
          color: Colors.white, // choose the color of your back arrow
        ),
      ),
      body: PhotoViewGallery.builder(
        itemCount: photos.length,
        builder: (context, index) {
          final uri = Uri.tryParse(photos[index]);
          final isNetworkImage = uri != null && uri.scheme.startsWith('http');
          return PhotoViewGalleryPageOptions.customChild(
            child: isNetworkImage
                ? CachedNetworkImage(
                    imageUrl: photos[index],
                    placeholder: (context, url) => Container(color: Colors.grey),
                    errorWidget: (context, url, error) => Container(color: Colors.red.shade400),
                  )
                : Image.file(
                    File(photos[index]),
                    fit: BoxFit.cover,
                  ),
            minScale: PhotoViewComputedScale.contained * 0.8,
            maxScale: PhotoViewComputedScale.covered * 2,
            heroAttributes: PhotoViewHeroAttributes(tag: photos[index]),
          );
        },
        pageController: PageController(initialPage: this.index),
        enableRotation: true,
      ),
    );
  }
}

//reference : https://github.com/Rapid-Technology/flutter_gallery