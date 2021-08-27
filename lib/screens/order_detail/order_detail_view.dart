import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:swift/helper/colors.dart';
import 'package:swift/helper/text_styles.dart';
import 'package:swift/helper/utils.dart';
import 'package:swift/models/order_details_model.dart';
import 'package:swift/screens/order_detail/payment_bloc/payment_bloc.dart';
import 'package:swift/widgets/custom_button.dart';
import 'detail_bloc/order_detail_bloc.dart';

class OrderDetailView extends StatefulWidget {
  OrderDetailView(this.orderId);
  final String orderId;
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
          "ORDER DETAILS",
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
              Utils.showToast(context, false, "Payment Succeded", 2);
            }
            if (state is PaymentFailed) {
              Utils.showToast(context, true, "Payment Failed", 2);
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
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) {
                return Form(
                  key: _formkey,
                  child: AlertDialog(
                    title: Text(
                      'Add Payment',
                      style: CustomTextStyles.boldTitleText,
                    ),
                    content: TextFormField(
                      style: CustomTextStyles.textField,
                      controller: paymentController,
                      keyboardType: TextInputType.number,
                      validator: RequiredValidator(errorText: "Required"),
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          'Cancel',
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
                          'OK',
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
      ),
    );
  }
}
