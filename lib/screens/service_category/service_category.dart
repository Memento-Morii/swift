import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:swift/helper/colors.dart';
import 'package:swift/helper/text_styles.dart';
import 'package:swift/models/service_category_model.dart';
import 'package:swift/screens/create_order/create_order_view.dart';
import 'package:swift/screens/service_category/bloc/service_categories_bloc.dart';
import 'package:swift/widgets/custom_network_image.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ServiceCategory extends StatefulWidget {
  ServiceCategory({this.serviceId, this.name});
  final int serviceId;
  final String name;
  @override
  _ServiceCategoryState createState() => _ServiceCategoryState();
}

class _ServiceCategoryState extends State<ServiceCategory> {
  // CreateOrderBloc _orderBloc;
  ServiceCategoriesBloc _categoriesBloc;
  @override
  void initState() {
    _categoriesBloc = ServiceCategoriesBloc();
    _categoriesBloc.add(FetchServiceCategories(widget.serviceId));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.name.toUpperCase(),
          style: CustomTextStyles.bigWhiteText,
        ),
      ),
      body: BlocProvider(
        create: (context) => ServiceCategoriesBloc(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: BlocBuilder<ServiceCategoriesBloc, ServiceCategoriesState>(
            bloc: _categoriesBloc,
            builder: (context, state) {
              if (state is ServiceCategoriesInitial) {
                return Center(child: CircularProgressIndicator());
              } else if (state is ServiceCategoriesLoaded) {
                List<ServiceCategoryModel> categories = state.categories;
                return ListView.separated(
                  itemCount: categories.length,
                  itemBuilder: (context, index) {
                    ServiceCategoryModel _category = categories[index];
                    return Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: CustomColors.primaryColor,
                          width: 3,
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Row(
                            children: [
                              CustomNetworkImage(
                                imgUrl: _category.image,
                              ),
                              SizedBox(width: 10),
                              Container(
                                height: 50,
                                width: 2,
                                color: CustomColors.primaryColor,
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
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => CreateOrderView(
                                    serviceCategory: _category,
                                  ),
                                ),
                              );
                            },
                            child: Text(
                              AppLocalizations.of(context).orders,
                              style: CustomTextStyles.coloredBold,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return SizedBox(height: 20);
                  },
                );
              } else if (state is ServiceCategoriesEmpty) {
                return Center(
                    child: Text(
                  'Empty Categories',
                  style: CustomTextStyles.errorText,
                ));
              } else {
                return Center(
                    child: Text(
                  AppLocalizations.of(context).failed,
                  style: CustomTextStyles.errorText,
                ));
              }
            },
          ),
        ),
      ),
    );
  }
}
