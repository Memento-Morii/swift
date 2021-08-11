import 'dart:developer';

import 'package:custom_radio_grouped_button/custom_radio_grouped_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:swift/helper/colors.dart';
import 'package:swift/helper/text_styles.dart';
import 'package:swift/models/service_model.dart';
import 'package:swift/models/service_provider_request_model.dart';
import 'package:swift/screens/register/add_services/bloc/add_service_bloc.dart';
import 'package:swift/screens/register/add_services/bloc/create_service_provider_bloc.dart';
import 'package:swift/widgets/category_card.dart';

class AddService extends StatefulWidget {
  @override
  _AddServiceState createState() => _AddServiceState();
}

class _AddServiceState extends State<AddService> {
  RangeValues selectedPriceRanges = RangeValues(100, 800);
  RangeValues selectedTimeRanges = RangeValues(100, 900);
  AddServiceBloc _serviceBloc;
  CreateServiceProviderBloc _serviceProviderBloc;
  ServiceProviderRequest _requestModel = ServiceProviderRequest(
    description: "This is my description",
    address: "some address",
    document: "test",
    lat: 4.54,
    lng: 32.34,
    timeRangeFrom: DateTime.now(),
    timeRangeTo: DateTime.now(),
  );
  List<ServiceModel> categories = [];
  int serviceId;
  int serviceCategoryId;
  @override
  void initState() {
    _serviceBloc = AddServiceBloc();
    _serviceProviderBloc = CreateServiceProviderBloc();
    _serviceBloc.add(FetchServices());
    super.initState();
  }

  getServiceName(List<ServiceModel> _service) {
    List<String> names = [];
    _service.forEach((element) {
      names.add(element.name);
    });
    return names;
  }

  // getCategories({List<ServiceModel> services, String name}) {
  //   categories.clear();
  //   services.forEach((element) {
  //     if (element.name == name) {
  //       element.serviceCategories.forEach((element) {
  //         categories.add(element);
  //       });
  //       _requestModel.serviceId = element.id;
  //     }
  //   });
  //   return categories;
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => AddServiceBloc(),
        child: Center(
          child: SingleChildScrollView(
            child: SafeArea(
              child: BlocBuilder<AddServiceBloc, AddServiceState>(
                bloc: _serviceBloc,
                builder: (context, state) {
                  if (state is AddServiceInitial) {
                    return Center(child: CircularProgressIndicator());
                  } else if (state is AddServiceLoaded) {
                    List<String> names = getServiceName(state.service);
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'Add your service',
                          style: CustomTextStyles.headlineText,
                        ),
                        SizedBox(height: 20),
                        CustomRadioButton(
                          buttonTextStyle: ButtonTextStyle(
                            selectedColor: Colors.white,
                            unSelectedColor: CustomColors.primaryColor,
                            textStyle: CustomTextStyles.textField,
                          ),
                          unSelectedColor: Colors.white,
                          buttonLables: names,
                          buttonValues: names,
                          spacing: 0,
                          radioButtonValue: (value) {
                            setState(() {
                              // getCategories(
                              //   services: state.service,
                              //   name: value,
                              // );
                            });
                          },
                          horizontal: false,
                          enableButtonWrap: false,
                          width: 150,
                          absoluteZeroSpacing: false,
                          selectedColor: CustomColors.primaryColor,
                          padding: 10,
                        ),
                        SizedBox(height: 30),
                        categories.length == 0
                            ? SizedBox()
                            : GridView.builder(
                                shrinkWrap: true,
                                gridDelegate:
                                    SliverGridDelegateWithMaxCrossAxisExtent(
                                  maxCrossAxisExtent: 150,
                                  childAspectRatio: 3 / 2,
                                  crossAxisSpacing: 20,
                                  mainAxisSpacing: 20,
                                ),
                                itemCount: categories.length,
                                itemBuilder: (context, index) {
                                  return InkWell(
                                    onTap: () {
                                      _requestModel.serviceCategoryId =
                                          categories[index].id;
                                      print(categories[index].id);
                                    },
                                    child: CategoryCard(
                                      categories[index],
                                    ),
                                  );
                                },
                              ),
                        Text(
                          'Price Range',
                          style: CustomTextStyles.mediumText,
                        ),
                        SliderTheme(
                          data: SliderThemeData(
                            showValueIndicator: ShowValueIndicator.always,
                            valueIndicatorColor: CustomColors.primaryColor,
                            valueIndicatorTextStyle:
                                CustomTextStyles.mediumText,
                          ),
                          child: RangeSlider(
                              labels: RangeLabels(
                                "${selectedPriceRanges.start.round()}",
                                "${selectedPriceRanges.end.round()}",
                              ),
                              activeColor: CustomColors.primaryColor,
                              values: selectedPriceRanges,
                              max: 1000,
                              min: 100,
                              onChanged: (newRanges) {
                                setState(() {
                                  selectedPriceRanges = newRanges;
                                });
                                _requestModel.priceRangeFrom =
                                    newRanges.start.round().ceilToDouble();
                                _requestModel.priceRangeTo =
                                    newRanges.end.round().ceilToDouble();
                              }),
                        ),
                        SizedBox(height: 30),
                        Text(
                          'Time Range',
                          style: CustomTextStyles.mediumText,
                        ),
                        SliderTheme(
                          data: SliderThemeData(
                            showValueIndicator: ShowValueIndicator.always,
                            valueIndicatorColor: CustomColors.primaryColor,
                            valueIndicatorTextStyle:
                                CustomTextStyles.mediumText,
                          ),
                          child: RangeSlider(
                            activeColor: CustomColors.primaryColor,
                            values: selectedTimeRanges,
                            max: 1000,
                            min: 100,
                            labels: RangeLabels(
                              "${selectedTimeRanges.start.round()}",
                              "${selectedTimeRanges.end.round()}",
                            ),
                            onChanged: (newRanges) {
                              setState(() {
                                selectedTimeRanges = newRanges;
                              });
                            },
                          ),
                        ),
                        Text(
                          'Address',
                          style: CustomTextStyles.mediumText,
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 10),
                          child: TextField(
                            style: CustomTextStyles.textField,
                            decoration: InputDecoration(
                              hintText: "Add your address",
                              hintStyle: CustomTextStyles.textField,
                            ),
                          ),
                        ),
                      ],
                    );
                  } else {
                    return Center(child: Text('Failed'));
                  }
                },
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: BlocProvider(
        create: (context) => CreateServiceProviderBloc(),
        child: FloatingActionButton(
          backgroundColor: CustomColors.primaryColor,
          onPressed: () async {
            inspect(_requestModel);
            SharedPreferences prefs = await SharedPreferences.getInstance();
            var token = prefs.get("token");
            _serviceProviderBloc.add(CreateServiceProvider(
              token: token,
              request: _requestModel,
              context: context,
            ));
          },
          child: BlocBuilder<CreateServiceProviderBloc,
              CreateServiceProviderState>(
            bloc: _serviceProviderBloc,
            builder: (context, state) {
              if (state is CreateServiceProviderInitial) {
                return Icon(Icons.add);
              } else if (state is CreateServiceProviderLoading) {
                return Center(child: CircularProgressIndicator());
              } else {
                return Text('Failed');
              }
            },
          ),
        ),
      ),
    );
  }
}
