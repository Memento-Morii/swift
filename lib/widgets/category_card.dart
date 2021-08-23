import 'package:flutter/material.dart';
import 'package:swift/helper/text_styles.dart';
import 'package:swift/models/service_model.dart';
import 'package:swift/widgets/custom_network_image.dart';

class CategoryCard extends StatelessWidget {
  CategoryCard(this.service);
  final ServiceModel service;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          CustomNetworkImage(
            imgUrl: service.image,
          ),
          SizedBox(height: 10),
          Text(
            service.name,
            style: CustomTextStyles.textField,
          ),
        ],
      ),
    );
  }
}
