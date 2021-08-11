import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:swift/helper/colors.dart';
import 'package:swift/helper/text_styles.dart';
import 'package:swift/models/order_request_model.dart';
import 'package:swift/models/service_category_model.dart';
import 'package:swift/screens/create_order/bloc/create_order_bloc.dart';
import 'package:swift/widgets/custom_button.dart';
import 'package:swift/widgets/myTextField.dart';

class CreateOrderView extends StatefulWidget {
  CreateOrderView({this.serviceCategory, this.serviceId});
  final ServiceCategoryModel serviceCategory;
  final int serviceId;
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
    return Scaffold(
      appBar: AppBar(),
      body: BlocProvider(
        create: (context) => CreateOrderBloc(),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(50, 0, 20, 0),
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
                        Container(
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: CustomColors.primaryColor,
                              width: 3,
                            ),
                          ),
                          child: Image.asset(
                            "assets/mechanic.png",
                            height: 80,
                            fit: BoxFit.cover,
                          ),
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
                        SharedPreferences prefs = await SharedPreferences.getInstance();
                        var token = prefs.get("token");
                        OrderRequest orderRequest = OrderRequest(
                          lat: "0.01",
                          lng: "0.22",
                          blockNumber: blockController.text.trim(),
                          houseNumber: houseController.text.trim(),
                          siteName: siteController.text.trim(),
                          serviceId: widget.serviceId,
                          serviceCategoryId: widget.serviceCategory.id,
                        );
                        _orderBloc.add(OrderEvent(
                          context: context,
                          isAddress: true,
                          orderRequest: orderRequest,
                          token: token,
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
                              SharedPreferences prefs = await SharedPreferences.getInstance();
                              var token = prefs.get("token");
                              OrderRequest orderRequest = OrderRequest(
                                serviceId: widget.serviceId,
                                serviceCategoryId: widget.serviceCategory.id,
                              );
                              _orderBloc.add(OrderEvent(
                                context: context,
                                isAddress: false,
                                orderRequest: orderRequest,
                                token: token,
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

// showDialog(
                              //   context: context,
                              //   builder: (context) => AlertDialog(
                              //     title: Text(widget.service.name),
                              //     titleTextStyle: CustomTextStyles.boldTitleText,
                              //     content: StatefulBuilder(
                              //       builder: (BuildContext context, StateSetter setState) {
                              //         return Container(
                              //           height: MediaQuery.of(context).size.height * 0.5,
                              //           child: SingleChildScrollView(
                              //             child: Column(
                              //               crossAxisAlignment: CrossAxisAlignment.start,
                              //               children: <Widget>[
                              //                 Text(
                              //                   _category.name,
                              //                   style: CustomTextStyles.boldText,
                              //                 ),
                              //                 SizedBox(height: 20),
                              //                 Text(
                              //                   "Do you want a new address?",
                              //                   style: CustomTextStyles.textField,
                              //                 ),
                              //                 Row(
                              //                   children: [
                              //                     Text(
                              //                       "Yes",
                              //                       style: CustomTextStyles.boldMediumText,
                              //                     ),
                              //                     Radio(
                              //                       value: true,
                              //                       groupValue: isAddress,
                              //                       onChanged: (value) {
                              //                         print(value);
                              //                         setState(() {
                              //                           isAddress = value;
                              //                         });
                              //                       },
                              //                     ),
                              //                     Text(
                              //                       "No",
                              //                       style: CustomTextStyles.boldMediumText,
                              //                     ),
                              //                     Radio(
                              //                       value: false,
                              //                       groupValue: isAddress,
                              //                       onChanged: (value) {
                              //                         print(value);
                              //                         setState(() {
                              //                           isAddress = value;
                              //                         });
                              //                       },
                              //                     ),
                              //                   ],
                              //                 ),
                              //                 Text(
                              //                   "House Number",
                              //                   style: CustomTextStyles.textField,
                              //                 ),
                              //                 TextFormField(
                              //                   controller: houseController,
                              //                   enabled: isAddress ? true : false,
                              //                 ),
                              //                 SizedBox(height: 10),
                              //                 Text(
                              //                   "Block Number",
                              //                   style: CustomTextStyles.textField,
                              //                 ),
                              //                 TextFormField(
                              //                   controller: blockController,
                              //                   enabled: isAddress ? true : false,
                              //                 ),
                              //                 SizedBox(height: 10),
                              //                 Text(
                              //                   "Site Name",
                              //                   style: CustomTextStyles.textField,
                              //                 ),
                              //                 TextFormField(
                              //                   controller: siteController,
                              //                   enabled: isAddress ? true : false,
                              //                 ),
                              //               ],
                              //             ),
                              //           ),
                              //         );
                              //       },
                              //     ),
                              //     actions: [
                              //       TextButton(
                              //         onPressed: () {
                              //           Navigator.pop(context);
                              //         },
                              //         child: Text(
                              //           'Cancel',
                              //           style: CustomTextStyles.boldMediumText,
                              //         ),
                              //       ),
                              //       TextButton(
                              //         onPressed: () async {
                              //           // print(_category.id);
                              //           //
                              //           SharedPreferences prefs =
                              //               await SharedPreferences.getInstance();
                              //           var token = prefs.get("token");
                              //           OrderRequest orderRequest = OrderRequest(
                              //             lat: "0.01",
                              //             lng: "0.22",
                              //             blockNumber: blockController.text.trim(),
                              //             houseNumber: houseController.text.trim(),
                              //             siteName: siteController.text.trim(),
                              //             serviceId: widget.service.id,
                              //             serviceCategoryId: _category.id,
                              //           );
                              //           _orderBloc.add(OrderEvent(
                              //             orderRequest: orderRequest,
                              //             isAddress: isAddress,
                              //             context: context,
                              //             token: token,
                              //           ));
                              //         },
                              //         child: Text(
                              //           'Submit',
                              //           style: CustomTextStyles.coloredBold,
                              //         ),
                              //       ),
                              //     ],
                              //   ),
                              // );