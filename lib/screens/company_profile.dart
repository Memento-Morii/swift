import 'package:flutter/material.dart';
import 'package:swift/helper/text_styles.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CompanyProfile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        child: Column(
          children: <Widget>[
            Text(
              AppLocalizations.of(context).companyProfile.toUpperCase(),
              style: CustomTextStyles.bigBoldText,
            ),
            SizedBox(height: 20),
            Text(
              AppLocalizations.of(context).aboutUsDescription,
              style: CustomTextStyles.boldText,
            ),
          ],
        ),
      ),
    );
  }
}
