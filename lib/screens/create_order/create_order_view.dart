import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:swift/helper/colors.dart';
import 'package:swift/helper/text_styles.dart';
import 'package:swift/helper/utils.dart';
import 'package:swift/models/location_model.dart';
import 'package:swift/models/order_request_model.dart';
import 'package:swift/models/service_category_model.dart';
import 'package:swift/screens/create_order/bloc/create_order_bloc.dart';
import 'package:swift/widgets/custom_button.dart';
import 'package:swift/widgets/custom_network_image.dart';
import 'package:swift/widgets/myTextField.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
  GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  LocationModel _selectedLocation;
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
        title: Text(
          AppLocalizations.of(context).createOrder.toUpperCase(),
          style: CustomTextStyles.bigWhiteText,
        ),
      ),
      body: BlocProvider(
        create: (context) => CreateOrderBloc(),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(50, 10, 20, 0),
            child: BlocBuilder<CreateOrderBloc, CreateOrderState>(
              bloc: _orderBloc,
              builder: (context, state) {
                return Form(
                  key: _formkey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                        AppLocalizations.of(context).siteName,
                        style: CustomTextStyles.mediumText,
                      ),
                      Container(
                        width: 200,
                        margin: EdgeInsets.symmetric(vertical: 10),
                        child: Utils.siteNameWidget(
                          siteController: siteController,
                          color: CustomColors.primaryColor,
                          onSuggestionSelected: (suggestion) {
                            setState(() {
                              siteController.text = suggestion.name;
                              _selectedLocation = suggestion;
                            });
                          },
                        ),
                      ),
                      Text(
                        AppLocalizations.of(context).blockNumber,
                        style: CustomTextStyles.mediumText,
                      ),
                      MyTextField(
                        controller: blockController,
                      ),
                      Text(
                        AppLocalizations.of(context).houseNo,
                        style: CustomTextStyles.mediumText,
                      ),
                      MyTextField(
                        controller: houseController,
                      ),
                      SizedBox(height: 10),
                      CustomButton(
                        // width: 120,
                        color: CustomColors.primaryColor,
                        child: Text(
                          AppLocalizations.of(context).orderNow,
                          style: CustomTextStyles.mediumWhiteText,
                        ),
                        onPressed: () async {
                          if (_formkey.currentState.validate()) {
                            if (_selectedLocation != null) {
                              OrderRequest orderRequest = OrderRequest(
                                lat: _selectedLocation.lat,
                                lng: _selectedLocation.lng,
                                blockNumber: blockController.text.trim(),
                                houseNumber: houseController.text.trim(),
                                siteName: _selectedLocation.name,
                                serviceId: widget.serviceCategory.serviceId,
                                serviceCategoryId: widget.serviceCategory.id,
                              );
                              _orderBloc.add(OrderEvent(
                                context: context,
                                isAddress: true,
                                orderRequest: orderRequest,
                              ));
                            } else {
                              Utils.showToast(
                                context,
                                true,
                                AppLocalizations.of(context).selectLocation,
                                2,
                              );
                            }
                          }
                        },
                      ),
                      SizedBox(height: 30),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              AppLocalizations.of(context).instead,
                              style: CustomTextStyles.normalText,
                            ),
                            SizedBox(width: 10),
                            CustomButton(
                              // width: 220,
                              color: CustomColors.primaryColor,
                              child: Text(
                                AppLocalizations.of(context).useRegistered,
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
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
