import 'dart:developer';
import 'package:custom_radio_grouped_button/custom_radio_grouped_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:swift/helper/colors.dart';
import 'package:swift/helper/text_styles.dart';
import 'package:swift/helper/utils.dart';
import 'package:swift/models/location_model.dart';
import 'package:swift/models/service_model.dart';
import 'package:swift/models/service_provider_request_model.dart';
import 'package:swift/screens/home/home_view.dart';
import 'package:swift/screens/register/add_services/bloc/add_service_bloc.dart';
import 'package:swift/screens/register/add_services/bloc/create_service_provider_bloc.dart';
import 'package:swift/widgets/category_card.dart';

class AddService extends StatefulWidget {
  AddService(this.isAnother);
  final bool isAnother;
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
    timeRangeFrom: DateTime.now(),
    lat: 2.32324,
    lng: 4.53432,
    timeRangeTo: DateTime.now(),
  );
  List<ServiceModel> categories = [];
  int serviceId;
  int serviceCategoryId;
  LocationModel selectedLocation;
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

  getCategories({List<ServiceModel> services, String name}) {
    categories.clear();
    services.forEach((element) {
      if (element.name == name) {
        element.serviceCategories.forEach((element) {
          categories.add(element);
        });
        _requestModel.serviceId = element.id;
      }
    });
    return categories;
  }

  TextEditingController addressController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CreateServiceProviderBloc(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'ADD SERVICE',
            style: CustomTextStyles.bigWhiteText,
          ),
        ),
        body: BlocProvider(
          create: (context) => AddServiceBloc(),
          child: SafeArea(
            child: BlocListener<CreateServiceProviderBloc, CreateServiceProviderState>(
              listener: (context, state) {
                if (state is CreateServiceProviderSuccess) {
                  widget.isAnother
                      ? Utils.showToast(context, false, "Added New Service", 2)
                      : Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Home(),
                          ),
                        );
                }
              },
              child: BlocBuilder<AddServiceBloc, AddServiceState>(
                bloc: _serviceBloc,
                builder: (context, state) {
                  if (state is AddServiceInitial) {
                    return Center(child: CircularProgressIndicator());
                  } else if (state is AddServiceLoaded) {
                    List<String> names = getServiceName(state.service);
                    List<LocationModel> getSuggestions(String query) =>
                        List.of(state.locations).where((element) {
                          final nameLower = element.name.toLowerCase();
                          final queryLower = query.toLowerCase();
                          return nameLower.contains(queryLower);
                        }).toList();
                    return Padding(
                      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            TypeAheadField<LocationModel>(
                              textFieldConfiguration: TextFieldConfiguration(
                                controller: addressController,
                                style: CustomTextStyles.textField,
                                decoration: InputDecoration(
                                  contentPadding:
                                      EdgeInsets.symmetric(horizontal: 32, vertical: 20),
                                  border: InputBorder.none,
                                  hintText: "Search Connection",
                                  hintStyle: CustomTextStyles.textField,
                                  prefixIcon: Icon(
                                    Icons.search,
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                              suggestionsCallback: (pattern) {
                                return getSuggestions(pattern);
                              },
                              itemBuilder: (context, itemData) {
                                return ListTile(
                                    title: Text(
                                  itemData.name,
                                  style: CustomTextStyles.boldMediumText,
                                ));
                              },
                              onSuggestionSelected: (suggestion) {
                                setState(() {
                                  addressController.text = suggestion.name;
                                  selectedLocation = suggestion;
                                });
                              },
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
                                  getCategories(
                                    services: state.service,
                                    name: value,
                                  );
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
                                    physics: const NeverScrollableScrollPhysics(),
                                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 3,
                                      childAspectRatio: 0.75,
                                      crossAxisSpacing: 20,
                                      mainAxisSpacing: 20,
                                    ),
                                    itemCount: categories.length,
                                    itemBuilder: (context, index) {
                                      return InkWell(
                                        onTap: () {
                                          _requestModel.serviceCategoryId = categories[index].id;
                                          print(categories[index].id);
                                          Utils.showToast(
                                            context,
                                            false,
                                            "${categories[index].name} is Selected!",
                                            2,
                                          );
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
                                valueIndicatorTextStyle: CustomTextStyles.mediumText,
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
                                valueIndicatorTextStyle: CustomTextStyles.mediumText,
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
                          ],
                        ),
                      ),
                    );
                  } else {
                    return Center(child: Text('Failed'));
                  }
                },
              ),
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
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
          child: BlocBuilder<CreateServiceProviderBloc, CreateServiceProviderState>(
            bloc: _serviceProviderBloc,
            builder: (context, state) {
              if (state is CreateServiceProviderInitial) {
                return Icon(
                  Icons.add,
                  color: Colors.white,
                );
              } else if (state is CreateServiceProviderLoading) {
                return SizedBox(
                  height: 30,
                  width: 30,
                  child: Center(
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    ),
                  ),
                );
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
