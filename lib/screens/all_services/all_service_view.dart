import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:swift/helper/colors.dart';
import 'package:swift/helper/text_styles.dart';
import 'package:swift/models/service_category_model.dart';
import 'package:swift/models/service_model.dart';
import 'package:swift/screens/create_order/create_order_view.dart';
import 'package:swift/screens/register/add_services/bloc/add_service_bloc.dart';
import 'package:swift/widgets/custom_network_image.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AllService extends StatefulWidget {
  @override
  _AllServiceState createState() => _AllServiceState();
}

class _AllServiceState extends State<AllService> {
  AddServiceBloc _bloc;
  @override
  void initState() {
    _bloc = AddServiceBloc();
    _bloc.add(FetchServices());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context).allServices,
          style: CustomTextStyles.bigWhiteText,
        ),
      ),
      body: BlocProvider(
        create: (context) => AddServiceBloc(),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: BlocBuilder<AddServiceBloc, AddServiceState>(
            bloc: _bloc,
            builder: (context, state) {
              if (state is AddServiceInitial) {
                return Center(child: CircularProgressIndicator());
              } else if (state is AddServiceLoaded) {
                List<ServiceModel> _services = state.service;
                return ListView.separated(
                    shrinkWrap: true,
                    itemCount: _services.length,
                    separatorBuilder: (context, index) {
                      return SizedBox(height: 40);
                    },
                    itemBuilder: (context, bigIndex) {
                      ServiceModel _service = _services[bigIndex];
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width * 0.75,
                            padding: EdgeInsets.all(10),
                            color: Color(0xff09DE04),
                            child: Text(
                              _service.name.toUpperCase(),
                              style: CustomTextStyles.bigWhiteText,
                            ),
                          ),
                          SizedBox(height: 10),
                          ListView.separated(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: _service.serviceCategories.length,
                            itemBuilder: (context, smallIndex) {
                              ServiceModel _categories = _service.serviceCategories[smallIndex];
                              return InkWell(
                                onTap: () {
                                  ServiceCategoryModel _category = ServiceCategoryModel(
                                    id: _categories.id,
                                    image: _categories.image,
                                    name: _categories.name,
                                    serviceId: _categories.serviceId,
                                  );
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => CreateOrderView(
                                        serviceCategory: _category,
                                      ),
                                    ),
                                  );
                                },
                                child: Container(
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                    color: CustomColors.primaryColor,
                                    width: 2,
                                  )),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Text(
                                        _categories.name,
                                        style: CustomTextStyles.boldMediumText,
                                      ),
                                      CustomNetworkImage(
                                        imgUrl: _categories.image,
                                      )
                                    ],
                                  ),
                                ),
                              );
                            },
                            separatorBuilder: (context, index) {
                              return SizedBox(height: 20);
                            },
                          ),
                        ],
                      );
                    });
              } else {
                return Center(
                  child: Text(
                    AppLocalizations.of(context).failed,
                    style: CustomTextStyles.bigErrorText,
                  ),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
