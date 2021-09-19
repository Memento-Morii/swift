import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:swift/helper/text_styles.dart';
import 'package:swift/models/provider_order_model.dart';
import 'package:swift/widgets/provider_order_card.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'bloc/provider_order_bloc.dart';

class ServiceProviderOrderView extends StatefulWidget {
  @override
  _ServiceProviderOrderViewState createState() => _ServiceProviderOrderViewState();
}

class _ServiceProviderOrderViewState extends State<ServiceProviderOrderView> {
  ProviderOrderBloc _providerOrderBloc;
  @override
  void initState() {
    _providerOrderBloc = ProviderOrderBloc();
    _providerOrderBloc.add(FetchProviderOrders());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProviderOrderBloc(),
      child: BlocBuilder<ProviderOrderBloc, ProviderOrderState>(
        bloc: _providerOrderBloc,
        builder: (context, state) {
          if (state is ProviderOrderInitial) {
            return Center(child: CircularProgressIndicator());
          } else if (state is ProviderOrderEmpty) {
            return Center(
                child: Text(
              AppLocalizations.of(context).orderEmpty,
              style: CustomTextStyles.bigErrorText,
            ));
          } else if (state is ProviderOrderLoaded) {
            List<ProviderOrderModel> orders = state.orders.reversed.toList();
            return ListView.separated(
              shrinkWrap: true,
              itemBuilder: (context, index) {
                ProviderOrderModel order = orders[index];
                return ProviderOrderCard(order);
              },
              separatorBuilder: (context, index) {
                return SizedBox(height: 20);
              },
              itemCount: orders.length,
            );
          } else {
            return Center(
              child: Container(
                height: 50,
                child: Column(
                  children: [
                    Text(
                      AppLocalizations.of(context).failed,
                      style: CustomTextStyles.bigErrorText,
                    ),
                    Text(
                      AppLocalizations.of(context).goToAnother,
                      style: CustomTextStyles.bigErrorText,
                    ),
                  ],
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
