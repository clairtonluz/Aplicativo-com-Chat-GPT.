import 'package:flutter/material.dart';

class ProfileWidget extends StatelessWidget {
  final String imageUrl;
  final String name;

  const ProfileWidget({super.key, required this.imageUrl, required this.name});

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    return SizedBox(
      width: screenSize.width * 0.9,
      height: screenSize.height * 0.4,
      child: Card(
        elevation: 4,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              CircleAvatar(
                backgroundImage: AssetImage(imageUrl),
                radius: 100.0,
              ),
              const SizedBox(height: 30),
              Text(
                name,
                style: const TextStyle(fontSize: 25),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
