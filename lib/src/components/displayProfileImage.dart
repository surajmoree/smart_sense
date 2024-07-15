import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';

import '../config/constant/app_colors.dart';

class DisplaySelectedImage extends StatelessWidget {
  final File imageFile;
  final String existedImageUrl;
  const DisplaySelectedImage(
      {super.key, required this.imageFile, this.existedImageUrl = ""});
  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 56,
      backgroundColor:mainColor,
      child: ClipOval(
        child: SizedBox.fromSize(
          size: const Size.fromRadius(53),
          child: (imageFile.path != "")
              ? Image.file(
                  imageFile,
                  filterQuality: FilterQuality.high,
                  fit: BoxFit.cover,
                )
              : (existedImageUrl.isNotEmpty)
                  ? CircleAvatar(
                      radius: 56,
                      backgroundColor: mainColor,
                      child: ClipOval(
                        child: SizedBox.fromSize(
                          size: const Size.fromRadius(53),
                          child: Image.memory( base64Decode(existedImageUrl), fit: BoxFit.cover,)
                       
                        ),
                      ),
                    )
                  : Image.asset(
                      'assets/images/person.png',
                      fit: BoxFit.cover,
                    ),
        ),
      ),
    );
  }
}
