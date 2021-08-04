import 'package:flutter/material.dart';

class CustomNetworkImage extends StatelessWidget {
  CustomNetworkImage({this.imgUrl, this.height = 50, this.width = 50});
  final String imgUrl;
  final double height;
  final double width;
  @override
  Widget build(BuildContext context) {
    return Image.asset(
      "data:image/jpeg;charset=utf-8;base64,$imgUrl",
      height: height,
      width: width,
    );
  }
}
