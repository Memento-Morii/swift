import 'package:flutter/material.dart';
import 'package:swift/helper/text_styles.dart';
import 'package:swift/widgets/personnel_card.dart';

class KeyPersonnel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'KEY PERSONNEL',
          style: CustomTextStyles.bigWhiteText,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        child: Column(
          children: <Widget>[
            PersonnelCard(),
          ],
        ),
      ),
    );
  }
}
