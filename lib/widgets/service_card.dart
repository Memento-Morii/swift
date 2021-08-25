import 'package:flutter/material.dart';
import 'package:swift/models/service_model.dart';
import 'package:swift/widgets/custom_network_image.dart';

class ServiceCard extends StatelessWidget {
  ServiceCard({this.result, this.width = 50});
  final ServiceModel result;
  final double width;
  @override
  Widget build(BuildContext context) {
    return CustomNetworkImage(
      imgUrl: result.image,
      width: width,
    );
  }
}
