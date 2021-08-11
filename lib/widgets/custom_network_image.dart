import 'dart:convert';

import 'package:flutter/material.dart';

class CustomNetworkImage extends StatelessWidget {
  CustomNetworkImage({this.imgUrl, this.height = 50, this.width = 50});
  final String imgUrl;
  final double height;
  final double width;
  @override
  Widget build(BuildContext context) {
    var decoded = Base64Decoder().convert(imgUrl);
    return Image.memory(
      decoded,
      height: height,
      width: width,
    );
  }
}
