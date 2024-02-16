import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:first_flutter_app/widgets/photo_view_page.dart';
import 'package:first_flutter_app/widgets/load_image.dart';

class LooksMaxxingWidget extends StatelessWidget {
  const LooksMaxxingWidget({Key? key}) : super(key: key);

  final List<String> photos = const [
    'https://m.media-amazon.com/images/I/71IeYNcBYdL._SX679_.jpg',
    'https://upload.wikimedia.org/wikipedia/commons/e/e7/Everest_North_Face_toward_Base_Camp_Tibet_Luca_Galuzzi_2006.jpg',
    'https://upload.wikimedia.org/wikipedia/commons/thumb/5/5d/Bas%C3%ADlica_de_Notre-Dame%2C_Montreal%2C_Canad%C3%A1%2C_2017-08-11%2C_DD_20-22_HDR.jpg/1293px-Bas%C3%ADlica_de_Notre-Dame%2C_Montreal%2C_Canad%C3%A1%2C_2017-08-11%2C_DD_20-22_HDR.jpg?20200123210836',
    'https://upload.wikimedia.org/wikipedia/commons/thumb/e/ea/Van_Gogh_-_Starry_Night_-_Google_Art_Project.jpg/1513px-Van_Gogh_-_Starry_Night_-_Google_Art_Project.jpg?20121101035929',
    'https://cdn.pixabay.com/photo/2015/04/19/08/32/marguerite-729510__340.jpg',
    'https://upload.wikimedia.org/wikipedia/commons/thumb/0/0c/Vincent_Van_Gogh_0010.jpg/924px-Vincent_Van_Gogh_0010.jpg',
    'https://upload.wikimedia.org/wikipedia/commons/thumb/8/8e/Welcome_to_Las_Vegas_sign.jpg/1600px-Welcome_to_Las_Vegas_sign.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("LOOOOOOksMaXXXXXXXing"),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              // Navigate to the NewPage when the "+" button is pressed
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const AddImage()), 
              );
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
                child: CachedNetworkImage(
                  imageUrl: photos[index],
                  fit: BoxFit.cover,
                  placeholder: (context, url) => Container(color: Colors.grey),
                  errorWidget: (context, url, error) => Container(
                    color: Colors.red.shade400,
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
