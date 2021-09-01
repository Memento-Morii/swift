import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:swift/helper/text_styles.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CustomField extends StatelessWidget {
  CustomField({
    this.hintText,
    this.iconUrl,
    this.isEmail = false,
    this.controller,
    this.textInputType = TextInputType.text,
  });
  final String hintText;
  final String iconUrl;
  final TextEditingController controller;
  final bool isEmail;
  final TextInputType textInputType;

  @override
  Widget build(BuildContext context) {
    RequiredValidator required =
        RequiredValidator(errorText: '$hintText ${AppLocalizations.of(context).required}');
    EmailValidator email = EmailValidator(errorText: AppLocalizations.of(context).validEmail);
    return Container(
      child: TextFormField(
        validator: isEmail ? email : required,
        controller: controller,
        style: CustomTextStyles.textField,
        maxLength: hintText == AppLocalizations.of(context).phone ? 10 : null,
        keyboardType: textInputType,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          hintText: hintText,
          errorStyle: CustomTextStyles.bigErrorText,
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
