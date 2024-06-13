import 'package:flutter/material.dart';

class DetailImagePage extends StatelessWidget {
  final String? imageUrl;

  const DetailImagePage({Key? key, this.imageUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: imageUrl != null
            ? Image.network(
                imageUrl!,
                width: 350,
                height: 500,
                fit: BoxFit.cover,
              )
            : Text('No image available'),
      ),
    );
  }
}
