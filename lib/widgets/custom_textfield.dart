import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:swift/helper/text_styles.dart';

class CustomField extends StatelessWidget {
  CustomField(
      {this.hintText,
      this.iconUrl,
      this.isEmail = false,
      this.controller,
      this.textInputType = TextInputType.text});
  final String hintText;
  final String iconUrl;
  final TextEditingController controller;
  final bool isEmail;
  final TextInputType textInputType;

  @override
  Widget build(BuildContext context) {
    RequiredValidator required = RequiredValidator(errorText: '$hintText is required');
    MultiValidator email = MultiValidator([
      RequiredValidator(errorText: "$hintText is required"),
      EmailValidator(errorText: "Enter vaild email address"),
    ]);
    return Container(
      // margin: EdgeInsets.only(top: 10),
      child: TextFormField(
        validator: isEmail ? email : required,
        controller: controller,
        style: CustomTextStyles.textField,
        keyboardType: textInputType,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          hintText: hintText,
          errorStyle: CustomTextStyles.errorText,
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
