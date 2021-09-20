import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:swift/helper/colors.dart';
import 'package:swift/helper/text_styles.dart';
import 'package:swift/helper/utils.dart';
import 'package:swift/models/order_details_model.dart';
import 'package:swift/screens/order_detail/payment_bloc/payment_bloc.dart';
import 'package:swift/widgets/custom_button.dart';
import 'package:swift/widgets/social_network.dart';
import 'detail_bloc/order_detail_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class OrderDetailView extends StatefulWidget {
  OrderDetailView({this.orderId, this.isUser});
  final String orderId;
  final bool isUser;
  @override
  _OrderDetailViewState createState() => _OrderDetailViewState();
}

class _OrderDetailViewState extends State<OrderDetailView> {
  OrderDetailBloc _detailBloc;
  PaymentBloc _paymentBloc;
  OrderDetailsModel details;
  @override
  void initState() {
    _detailBloc = OrderDetailBloc();
    _paymentBloc = PaymentBloc();
    _detailBloc.add(FetchDetails(widget.orderId));
    super.initState();
  }

  TextEditingController paymentController = TextEditingController();
  GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context).viewOrderDetails.toUpperCase(),
          style: CustomTextStyles.bigWhiteText,
        ),
      ),
      body: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => OrderDetailBloc(),
          ),
          BlocProvider(
            create: (context) => PaymentBloc(),
          ),
        ],
        child: BlocListener<PaymentBloc, PaymentState>(
          bloc: _paymentBloc,
          listener: (context, state) {
            if (state is PaymentSuccess) {
              Utils.showToast(context, false, AppLocalizations.of(context).success, 2);
            }
            if (state is PaymentFailed) {
              Utils.showToast(context, true, AppLocalizations.of(context).failed, 2);
            }
          },
          child: BlocBuilder<OrderDetailBloc, OrderDetailState>(
            bloc: _detailBloc,
            builder: (context, state) {
              if (state is DetailLoaded) {
                details = state.orderDetails;
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      CircleAvatar(
                        radius: 60,
                        backgroundImage: details.serviceProvider.user.userImage == null
                            ? AssetImage("assets/profile-user.png")
                            : MemoryImage(
                                Base64Decoder().convert(
                                  details.serviceProvider.user.userImage,
                                ),
                              ),
                      ),
                      SizedBox(height: 30),
                      Text(
                        AppLocalizations.of(context).providerInfo,
                        style: CustomTextStyles.boldTitleText,
                      ),
                      SizedBox(height: 20),
                      Text(
                        AppLocalizations.of(context).firstName,
                        style: CustomTextStyles.mediumText,
                      ),
                      Text(
                        details.serviceProvider.user.firstName,
                        style: CustomTextStyles.coloredBold,
                      ),
                      SizedBox(height: 10),
                      Text(
                        AppLocalizations.of(context).lastName,
                        style: CustomTextStyles.mediumText,
                      ),
                      Text(
                        details.serviceProvider.user.lastName,
                        style: CustomTextStyles.coloredBold,
                      ),
                      SizedBox(height: 10),
                      Text(
                        AppLocalizations.of(context).phone,
                        style: CustomTextStyles.mediumText,
                      ),
                      InkWell(
                        onTap: () async {
                          Utils.openLink(
                            url: details.serviceProvider.user.phoneNumber,
                            urlType: URL_TYPE.Telephone,
                          );
                        },
                        child: Text(
                          details.serviceProvider.user.phoneNumber,
                          style: CustomTextStyles.coloredBold,
                        ),
                      ),
                      // SizedBox(height: 10),
                      // Text(
                      //   AppLocalizations.of(context).email,
                      //   style: CustomTextStyles.mediumText,
                      // ),
                      // Text(
                      //   details.serviceProvider.user.email,
                      //   style: CustomTextStyles.coloredBold,
                      // ),
                    ],
                  ),
                );
              } else if (state is DetailFailed) {
                return Center(
                  child: Text(
                    AppLocalizations.of(context).failed,
                    style: CustomTextStyles.bigErrorText,
                  ),
                );
              } else {
                return Center(child: CircularProgressIndicator());
              }
            },
          ),
        ),
      ),
      bottomNavigationBar: widget.isUser
          ? Container(
              height: 50,
              margin: EdgeInsets.only(bottom: 10),
              child: CustomButton(
                // width: 140,
                color: CustomColors.primaryColor,
                child: Text(
                  AppLocalizations.of(context).goToPayment,
                  style: CustomTextStyles.mediumWhiteText,
                ),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return Form(
                        key: _formkey,
                        child: AlertDialog(
                          title: Text(
                            AppLocalizations.of(context).addPayment,
                            style: CustomTextStyles.boldTitleText,
                          ),
                          content: TextFormField(
                            style: CustomTextStyles.textField,
                            controller: paymentController,
                            keyboardType: TextInputType.number,
                            validator:
                                RequiredValidator(errorText: AppLocalizations.of(context).required),
                          ),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text(
                                AppLocalizations.of(context).cancel,
                                style: CustomTextStyles.textField,
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                if (_formkey.currentState.validate()) {
                                  Navigator.pop(context);
                                  _paymentBloc.add(MakePayment(
                                    orderId: details.id,
                                    payment: double.parse(paymentController.text.trim()),
                                    serviceProviderId: details.serviceProviderId,
                                    userId: details.userId,
                                  ));
                                }
                              },
                              child: Text(
                                AppLocalizations.of(context).go,
                                style: CustomTextStyles.textField,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
              ),
            )
          : null,
    );
  }
}
