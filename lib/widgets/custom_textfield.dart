import 'package:flutter/material.dart';
import 'package:swift/helper/text_styles.dart';

class CustomField extends StatelessWidget {
  CustomField({this.hintText, this.iconUrl, this.controller});
  final String hintText;
  final String iconUrl;
  final TextEditingController controller;
  @override
  Widget build(BuildContext context) {
    return Container(
      // margin: EdgeInsets.only(top: 10),
      child: TextFormField(
        controller: controller,
        style: CustomTextStyles.textField,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          hintText: hintText,
          hintStyle: CustomTextStyles.textField,
          prefixIcon: Padding(
            padding: EdgeInsets.all(10),
            child: Image.asset(
              iconUrl,
              height: 8,
            ),
          ),
        ),
      ),
    );
  }
}
