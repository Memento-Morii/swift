import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:swift/helper/colors.dart';
import 'package:swift/helper/text_styles.dart';
import 'package:swift/models/order_details_model.dart';
import 'package:swift/widgets/custom_button.dart';

import 'bloc/order_detail_bloc.dart';

class OrderDetailView extends StatefulWidget {
  OrderDetailView(this.orderId);
  final String orderId;
  @override
  _OrderDetailViewState createState() => _OrderDetailViewState();
}

class _OrderDetailViewState extends State<OrderDetailView> {
  OrderDetailBloc _detailBloc;
  @override
  void initState() {
    _detailBloc = OrderDetailBloc();
    _detailBloc.add(FetchDetails(widget.orderId));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "ORDER DETAILS",
          style: CustomTextStyles.bigWhiteText,
        ),
      ),
      body: BlocProvider(
        create: (context) => OrderDetailBloc(),
        child: BlocBuilder<OrderDetailBloc, OrderDetailState>(
          bloc: _detailBloc,
          builder: (context, state) {
            if (state is DetailLoaded) {
              OrderDetailsModel details = state.orderDetails;
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'Service Provider Information',
                      style: CustomTextStyles.boldTitleText,
                    ),
                    SizedBox(height: 20),
                    Text(
                      'First Name',
                      style: CustomTextStyles.mediumText,
                    ),
                    Text(
                      details.serviceProvider.user.firstName,
                      style: CustomTextStyles.coloredBold,
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Last Name',
                      style: CustomTextStyles.mediumText,
                    ),
                    Text(
                      details.serviceProvider.user.lastName,
                      style: CustomTextStyles.coloredBold,
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Phone',
                      style: CustomTextStyles.mediumText,
                    ),
                    Text(
                      details.serviceProvider.user.phoneNumber,
                      style: CustomTextStyles.coloredBold,
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Email',
                      style: CustomTextStyles.mediumText,
                    ),
                    Text(
                      details.serviceProvider.user.email,
                      style: CustomTextStyles.coloredBold,
                    ),
                  ],
                ),
              );
            } else if (state is DetailFailed) {
              return Center(
                child: Text(
                  "Failed",
                  style: CustomTextStyles.errorText,
                ),
              );
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
      bottomNavigationBar: Container(
        height: 50,
        margin: EdgeInsets.only(bottom: 10),
        child: CustomButton(
          width: 140,
          color: CustomColors.primaryColor,
          child: Text(
            'Go to payment',
            style: CustomTextStyles.mediumWhiteText,
          ),
          onPressed: () {},
        ),
      ),
    );
  }
}
