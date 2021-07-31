import 'package:flutter/material.dart';
import 'package:swift/helper/text_styles.dart';

class CategoryCard extends StatelessWidget {
  CategoryCard(this.name);
  final String name;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Container(
        height: 100,
        child: Column(
          children: <Widget>[
            Image.asset(
              "assets/lock.png",
              height: 50,
              fit: BoxFit.contain,
              width: MediaQuery.of(context).size.width,
            ),
            Text(
              name,
              style: CustomTextStyles.textField,
            ),
          ],
        ),
      ),
    );
  }
}
