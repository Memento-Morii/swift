import 'package:flutter/material.dart';
import 'package:swift/helper/colors.dart';

class MyTextField extends StatelessWidget {
  MyTextField({this.height = 50, this.width = 200, this.controller});
  final double height;
  final double width;
  final TextEditingController controller;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      margin: EdgeInsets.symmetric(vertical: 10),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 20.0),
          border: OutlineInputBorder(
            borderSide: BorderSide(
              width: 3,
              color: CustomColors.primaryColor,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              width: 2,
              color: CustomColors.primaryColor,
            ),
          ),
        ),
      ),
    );
  }
}
