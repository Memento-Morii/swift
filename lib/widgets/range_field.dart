import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:swift/helper/text_styles.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
          errorStyle: CustomTextStyles.bigErrorText,
        ),
        keyboardType: keyboardType,
        validator: RequiredValidator(
          errorText: AppLocalizations.of(context).required,
        ),
      ),
    );
  }
}
