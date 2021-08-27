import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:swift/helper/text_styles.dart';

class RangeField extends StatelessWidget {
  RangeField({this.controller, this.keyboardType = TextInputType.text});
  final TextEditingController controller;
  final TextInputType keyboardType;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.4,
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          errorStyle: CustomTextStyles.errorText,
        ),
        keyboardType: keyboardType,
        validator: RequiredValidator(errorText: "Required"),
      ),
    );
  }
}
