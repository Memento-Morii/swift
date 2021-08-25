import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:location/location.dart';
import 'package:swift/helper/colors.dart';
import 'package:swift/helper/text_styles.dart';
import 'package:swift/models/order_request_model.dart';
import 'package:swift/models/service_category_model.dart';
import 'package:swift/screens/create_order/bloc/create_order_bloc.dart';
import 'package:swift/widgets/custom_button.dart';
import 'package:swift/widgets/custom_network_image.dart';
import 'package:swift/widgets/myTextField.dart';

class CreateOrderView extends StatefulWidget {
  CreateOrderView({this.serviceCategory});
  final ServiceCategoryModel serviceCategory;
  @override
  _CreateOrderViewState createState() => _CreateOrderViewState();
}

class _CreateOrderViewState extends State<CreateOrderView> {
  CreateOrderBloc _orderBloc;
  TextEditingController houseController = TextEditingController();
  TextEditingController siteController = TextEditingController();
  TextEditingController blockController = TextEditingController();
  bool isAddress = false;
  @override
  void initState() {
    _orderBloc = CreateOrderBloc();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(widget.serviceCategory.serviceId);
    return Scaffold(
      appBar: AppBar(),
      body: BlocProvider(
        create: (context) => CreateOrderBloc(),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(50, 10, 20, 0),
            child: BlocBuilder<CreateOrderBloc, CreateOrderState>(
              bloc: _orderBloc,
              builder: (context, state) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      // mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Expanded(
                          child: Text(
                            widget.serviceCategory.name.toUpperCase(),
                            style: CustomTextStyles.bigBoldText,
                          ),
                        ),
                        SizedBox(width: 20),
                        CustomNetworkImage(
                          height: 110,
                          width: 110,
                          imgUrl: widget.serviceCategory.image,
                        )
                      ],
                    ),
                    SizedBox(height: 20),
                    Text(
                      'Site Name:',
                      style: CustomTextStyles.mediumText,
                    ),
                    MyTextField(
                      controller: siteController,
                    ),
                    Text(
                      'Block Number:',
                      style: CustomTextStyles.mediumText,
                    ),
                    MyTextField(
                      controller: blockController,
                    ),
                    Text(
                      'House Number:',
                      style: CustomTextStyles.mediumText,
                    ),
                    MyTextField(
                      controller: houseController,
                    ),
                    SizedBox(height: 10),
                    CustomButton(
                      width: 120,
                      color: CustomColors.primaryColor,
                      child: Text(
                        'Order Now',
                        style: CustomTextStyles.mediumWhiteText,
                      ),
                      onPressed: () async {
                        Location location = Location();
                        var serviceEnabled = await location.serviceEnabled();
                        if (!serviceEnabled) {
                          serviceEnabled = await location.requestService();
                        }
                        var mylocation = await location.getLocation();
                        print(mylocation.latitude);
                        print(mylocation.longitude);
                        OrderRequest orderRequest = OrderRequest(
                          lat: mylocation.latitude,
                          lng: mylocation.longitude,
                          blockNumber: blockController.text.trim(),
                          houseNumber: houseController.text.trim(),
                          siteName: siteController.text.trim(),
                          serviceId: widget.serviceCategory.serviceId,
                          serviceCategoryId: widget.serviceCategory.id,
                        );
                        _orderBloc.add(OrderEvent(
                          context: context,
                          isAddress: true,
                          orderRequest: orderRequest,
                        ));
                      },
                    ),
                    SizedBox(height: 30),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Instead,',
                            style: CustomTextStyles.normalText,
                          ),
                          SizedBox(width: 10),
                          CustomButton(
                            width: 220,
                            color: CustomColors.primaryColor,
                            child: Text(
                              'Use Registered Address',
                              style: CustomTextStyles.mediumWhiteText,
                            ),
                            onPressed: () async {
                              OrderRequest orderRequest = OrderRequest(
                                serviceId: widget.serviceCategory.serviceId,
                                serviceCategoryId: widget.serviceCategory.id,
                              );
                              _orderBloc.add(OrderEvent(
                                context: context,
                                isAddress: false,
                                orderRequest: orderRequest,
                              ));
                            },
                          ),
                        ],
                      ),
                    )
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
