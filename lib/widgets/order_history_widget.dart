import 'package:flutter/material.dart';
import 'package:swift/helper/colors.dart';
import 'package:swift/helper/text_styles.dart';
import 'package:swift/models/order_history_model.dart';
import 'package:intl/intl.dart';
import 'package:swift/screens/order_detail/order_detail_view.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'custom_network_image.dart';

class OrderHistoryWidget extends StatelessWidget {
  OrderHistoryWidget({this.order});
  final OrderHistoryModel order;
  final DateFormat dateFormat = DateFormat.yMMMMd().add_jm();
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Flexible(
            flex: 3,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Flexible(
                  flex: 2,
                  child: CustomNetworkImage(
                    imgUrl: order.serviceCategory.image,
                    height: 80,
                    width: 80,
                  ),
                ),
                SizedBox(width: 5),
                Flexible(
                  flex: 5,
                  child: Column(
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
                                    builder: (context) => OrderDetailView(
                                      orderId: order.orderId,
                                      isUser: true,
                                    ),
                                  ),
                                );
                              },
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all(CustomColors.primaryColor),
                              ),
                              child: Text(
                                AppLocalizations.of(context).viewOrderDetails,
                                style: CustomTextStyles.normalText2,
                              ),
                            )
                          : SizedBox(),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Flexible(
            flex: 1,
            child: Row(
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
                  order.orderHistory.status == 2
                      ? AppLocalizations.of(context).accepted
                      : AppLocalizations.of(context).pending,
                  style: CustomTextStyles.normalText,
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
