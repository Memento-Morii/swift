import 'package:flutter/material.dart';
import 'package:swift/helper/colors.dart';
import 'package:swift/helper/text_styles.dart';
import 'package:swift/models/order_history_model.dart';
import 'package:intl/intl.dart';
import 'package:swift/screens/order_detail/order_detail_view.dart';

import 'custom_network_image.dart';

class OrderHistoryWidget extends StatelessWidget {
  OrderHistoryWidget({this.order});
  final OrderHistoryModel order;
  final DateFormat dateFormat = DateFormat.yMMMMd().add_jm();
  @override
  Widget build(BuildContext context) {
    order.orderHistory.status == 2 ? print(order.orderId) : print('ob');
    return Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
                  SizedBox(height: 10),
                  order.orderHistory.status == 2
                      ? TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => OrderDetailView(order.orderId),
                              ),
                            );
                          },
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(CustomColors.primaryColor),
                          ),
                          child: Text(
                            'View Order Detail',
                            style: CustomTextStyles.normalText2,
                          ),
                        )
                      : SizedBox(),
                ],
              ),
            ],
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              order.orderHistory.status == 2
                  ? CircleAvatar(
                      radius: 5,
                      backgroundColor: Colors.green,
                    )
                  : CircleAvatar(
                      radius: 5,
                      backgroundColor: Colors.orange,
                    ),
              SizedBox(width: 5),
              Text(
                order.orderHistory.status == 2 ? 'Accepted' : "Pending",
                style: CustomTextStyles.normalText,
              )
            ],
          )
        ],
      ),
    );
  }
}
