import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:swift/helper/colors.dart';
import 'package:swift/helper/text_styles.dart';
import 'package:swift/models/order_request_model.dart';
import 'package:swift/models/service_model.dart';
import 'package:swift/screens/service_category/bloc/create_order_bloc.dart';

class ServiceCategory extends StatefulWidget {
  ServiceCategory({this.service});
  final ServiceModel service;
  @override
  _ServiceCategoryState createState() => _ServiceCategoryState();
}

class _ServiceCategoryState extends State<ServiceCategory> {
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
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          widget.service.name,
          style: CustomTextStyles.mediumText,
        ),
      ),
      body: BlocProvider(
        create: (context) => CreateOrderBloc(),
        child: BlocBuilder<CreateOrderBloc, CreateOrderState>(
          bloc: _orderBloc,
          builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: ListView.separated(
                itemCount: widget.service.serviceCategories.length,
                itemBuilder: (context, index) {
                  ServiceModel _category = widget.service.serviceCategories[index];
                  return Material(
                    borderRadius: BorderRadius.circular(30),
                    elevation: 6,
                    child: Container(
                      padding: EdgeInsets.all(10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Row(
                            children: [
                              CircleAvatar(
                                backgroundColor: CustomColors.primaryColor,
                                radius: 30,
                              ),
                              SizedBox(width: 20),
                              Text(
                                _category.name,
                                style: CustomTextStyles.mediumText,
                              ),
                            ],
                          ),
                          TextButton(
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  title: Text(widget.service.name),
                                  titleTextStyle: CustomTextStyles.boldTitleText,
                                  content: StatefulBuilder(
                                    builder: (BuildContext context, StateSetter setState) {
                                      return Container(
                                        height: MediaQuery.of(context).size.height * 0.5,
                                        child: SingleChildScrollView(
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Text(
                                                _category.name,
                                                style: CustomTextStyles.boldText,
                                              ),
                                              SizedBox(height: 20),
                                              Text(
                                                "Do you want a new address?",
                                                style: CustomTextStyles.textField,
                                              ),
                                              Row(
                                                children: [
                                                  Text(
                                                    "Yes",
                                                    style: CustomTextStyles.boldMediumText,
                                                  ),
                                                  Radio(
                                                    value: true,
                                                    groupValue: isAddress,
                                                    onChanged: (value) {
                                                      print(value);
                                                      setState(() {
                                                        isAddress = value;
                                                      });
                                                    },
                                                  ),
                                                  Text(
                                                    "No",
                                                    style: CustomTextStyles.boldMediumText,
                                                  ),
                                                  Radio(
                                                    value: false,
                                                    groupValue: isAddress,
                                                    onChanged: (value) {
                                                      print(value);
                                                      setState(() {
                                                        isAddress = value;
                                                      });
                                                    },
                                                  ),
                                                ],
                                              ),
                                              Text(
                                                "House Number",
                                                style: CustomTextStyles.textField,
                                              ),
                                              TextFormField(
                                                controller: houseController,
                                                enabled: isAddress ? true : false,
                                              ),
                                              SizedBox(height: 10),
                                              Text(
                                                "Block Number",
                                                style: CustomTextStyles.textField,
                                              ),
                                              TextFormField(
                                                controller: blockController,
                                                enabled: isAddress ? true : false,
                                              ),
                                              SizedBox(height: 10),
                                              Text(
                                                "Site Name",
                                                style: CustomTextStyles.textField,
                                              ),
                                              TextFormField(
                                                controller: siteController,
                                                enabled: isAddress ? true : false,
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: Text(
                                        'Cancel',
                                        style: CustomTextStyles.boldMediumText,
                                      ),
                                    ),
                                    TextButton(
                                      onPressed: () async {
                                        // print(_category.id);
                                        //
                                        SharedPreferences prefs =
                                            await SharedPreferences.getInstance();
                                        var token = prefs.get("token");
                                        OrderRequest orderRequest = OrderRequest(
                                          lat: "0.01",
                                          lng: "0.22",
                                          blockNumber: blockController.text.trim(),
                                          houseNumber: houseController.text.trim(),
                                          siteName: siteController.text.trim(),
                                          serviceId: widget.service.id,
                                          serviceCategoryId: _category.id,
                                        );
                                        _orderBloc.add(OrderEvent(
                                          orderRequest: orderRequest,
                                          isAddress: isAddress,
                                          context: context,
                                          token: token,
                                        ));
                                      },
                                      child: Text(
                                        'Submit',
                                        style: CustomTextStyles.coloredBold,
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                            child: Text(
                              "Order",
                              style: CustomTextStyles.coloredBold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
                separatorBuilder: (context, index) {
                  return SizedBox(height: 20);
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
