import 'package:flutter/material.dart';
import 'package:swift/helper/text_styles.dart';
import 'package:swift/models/provider_order_model.dart';
import 'package:swift/widgets/custom_network_image.dart';

class ProviderOrderCard extends StatefulWidget {
  ProviderOrderCard(this.order);
  final ProviderOrderModel order;
  @override
  _ProviderOrderCardState createState() => _ProviderOrderCardState();
}

class _ProviderOrderCardState extends State<ProviderOrderCard> {
  @override
  Widget build(BuildContext context) {
    return Material(
      // color: Colors.grey[300],
      elevation: 4,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        padding: EdgeInsets.all(10),
        child: Row(
          children: <Widget>[
            CustomNetworkImage(
              imgUrl: widget.order.serviceCategory.image,
              height: 80,
              width: 80,
            ),
            SizedBox(width: 30),
            Column(
              children: <Widget>[
                Text(
                  widget.order.serviceCategory.name,
                  style: CustomTextStyles.boldText,
                ),
                Text(
                  widget.order.service.name,
                  style: CustomTextStyles.normalText,
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    IconButton(
                      icon: Icon(
                        Icons.check_box,
                        color: Colors.green,
                        size: 30,
                      ),
                      onPressed: () {},
                    ),
                    SizedBox(height: 30),
                    IconButton(
                      icon: Icon(
                        Icons.cancel,
                        color: Colors.red,
                        size: 30,
                      ),
                      onPressed: () {},
                    ),
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
