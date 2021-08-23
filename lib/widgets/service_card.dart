import 'package:flutter/material.dart';
import 'package:swift/models/service_model.dart';
import 'package:swift/widgets/custom_network_image.dart';

class ServiceCard extends StatelessWidget {
  ServiceCard({this.result, this.width = 50});
  final ServiceModel result;
  final double width;
  @override
  Widget build(BuildContext context) {
    // print(result.image);
    return
        // Container(
        //   padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
        //   height: 80,
        //   width: 100,
        //   decoration: BoxDecoration(
        //       border: Border.all(
        //     color: CustomColors.primaryColor,
        //   )),
        //   child:
        //  Column(
        //   children: <Widget>[
        CustomNetworkImage(
      imgUrl: result.image,
      width: width,
    );
    // SizedBox(height: 10),
    //     Text(
    //       result.name,
    //       style: CustomTextStyles.normalColoredText,
    //     )
    //   ],
    // ),
    // );
  }
}
