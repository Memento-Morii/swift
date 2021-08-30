import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:swift/helper/text_styles.dart';
import 'package:swift/models/provider_order_model.dart';
import 'package:swift/screens/orders/service_provider_order/bloc/provider_order_bloc.dart';
import 'package:swift/widgets/custom_network_image.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ProviderOrderCard extends StatefulWidget {
  ProviderOrderCard(this.order);
  final ProviderOrderModel order;
  @override
  _ProviderOrderCardState createState() => _ProviderOrderCardState();
}

class _ProviderOrderCardState extends State<ProviderOrderCard> {
  ProviderOrderBloc _providerOrderBloc;
  @override
  void initState() {
    _providerOrderBloc = ProviderOrderBloc();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProviderOrderBloc(),
      child: Material(
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
              SizedBox(width: 50),
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
                  widget.order.orderHistory.status == 2
                      ? Text(
                          AppLocalizations.of(context).accepted,
                          style: CustomTextStyles.coloredBold,
                        )
                      : BlocBuilder<ProviderOrderBloc, ProviderOrderState>(
                          bloc: _providerOrderBloc,
                          builder: (context, state) {
                            if (state is ProviderOrderInitial) {
                              return Row(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  IconButton(
                                    icon: Icon(
                                      Icons.check_box,
                                      color: Colors.green,
                                      size: 30,
                                    ),
                                    onPressed: () {
                                      _providerOrderBloc.add(AcceptOrder(widget.order.orderId));
                                    },
                                  ),
                                  SizedBox(height: 30),
                                  IconButton(
                                    icon: Icon(
                                      Icons.cancel,
                                      color: Colors.red,
                                      size: 30,
                                    ),
                                    onPressed: () {
                                      _providerOrderBloc.add(RefuseOrder(widget.order.orderId));
                                    },
                                  ),
                                ],
                              );
                            } else if (state is ProviderOrderLoading) {
                              return SizedBox(
                                height: 30,
                                width: 30,
                                child: Center(
                                  child: CircularProgressIndicator(),
                                ),
                              );
                            } else if (state is ProviderOrderFailed) {
                              return Text(
                                "Failed",
                                style: CustomTextStyles.errorText,
                              );
                            } else if (state is Refused) {
                              return Text(
                                'Refused',
                                style: CustomTextStyles.coloredBold,
                              );
                            } else {
                              return Text(
                                AppLocalizations.of(context).accepted,
                                style: CustomTextStyles.coloredBold,
                              );
                            }
                          },
                        )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
