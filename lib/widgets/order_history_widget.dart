import 'package:flutter/material.dart';
import 'package:swift/helper/text_styles.dart';
import 'package:swift/models/order_history_model.dart';
import 'package:intl/intl.dart';

import 'custom_network_image.dart';

class OrderHistoryWidget extends StatelessWidget {
  OrderHistoryWidget({this.order});
  final OrderHistoryModel order;
  final DateFormat dateFormat = DateFormat.yMMMMd().add_jm();
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: <Widget>[
          // Container(
          //   height: 80,
          //   width: 80,
          //   decoration: BoxDecoration(
          //     borderRadius: BorderRadius.circular(15),
          //     color: CustomColors.primaryColor,
          //   ),
          // ),
          CustomNetworkImage(
            imgUrl: order.serviceCategory.image,
            height: 80,
            width: 80,
          ),
          SizedBox(width: 20),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                order.serviceCategory.name,
                style: CustomTextStyles.boldText,
              ),
              Text(
                order.service.name,
                style: CustomTextStyles.normalText,
              ),
              Text(
                dateFormat.format(order.serviceReceiveTime.toLocal()),
                style: CustomTextStyles.textField,
              ),
            ],
          )
        ],
      ),
    );
  }
}
