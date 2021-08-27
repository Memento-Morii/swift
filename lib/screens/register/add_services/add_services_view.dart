import 'dart:developer';
import 'dart:io';
import 'package:custom_radio_grouped_button/custom_radio_grouped_button.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:form_field_validator/form_field_validator.dart';
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
import 'package:swift/widgets/custom_button.dart';
import 'package:swift/widgets/range_field.dart';

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
  ServiceProviderRequest _requestModel = ServiceProviderRequest(document: null);
  List<ServiceModel> categories = [];
  int serviceId;
  int serviceCategoryId;
  LocationModel selectedLocation;
  GlobalKey<FormState> _formkey = GlobalKey<FormState>();
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
  TextEditingController priceFromController = TextEditingController();
  TextEditingController priceToController = TextEditingController();
  TextEditingController timeFromController = TextEditingController();
  TextEditingController timeToController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  final snackBar = SnackBar(content: Text('No Files Selected'));
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
              bloc: _serviceProviderBloc,
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
                if (state is CreateServiceProviderFailed) {
                  Utils.showToast(context, true, state.message, 2);
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
                      padding: const EdgeInsets.fromLTRB(10, 0, 10, 20),
                      child: SingleChildScrollView(
                        child: Form(
                          key: _formkey,
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
                                    hintText: "Search For Location",
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
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: <Widget>[
                                  RangeField(
                                    controller: priceFromController,
                                    keyboardType: TextInputType.number,
                                  ),
                                  Text(
                                    'To',
                                    style: CustomTextStyles.boldTitleText,
                                  ),
                                  RangeField(
                                    controller: priceToController,
                                    keyboardType: TextInputType.number,
                                  ),
                                ],
                              ),
                              SizedBox(height: 30),
                              Text(
                                'Time Range',
                                style: CustomTextStyles.mediumText,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: <Widget>[
                                  RangeField(controller: timeFromController),
                                  Text(
                                    'To',
                                    style: CustomTextStyles.boldTitleText,
                                  ),
                                  RangeField(controller: timeToController),
                                ],
                              ),
                              SizedBox(height: 30),
                              Text(
                                'Description',
                                style: CustomTextStyles.mediumText,
                              ),
                              TextFormField(
                                style: CustomTextStyles.textField,
                                controller: descriptionController,
                                decoration: InputDecoration(
                                  hintText: "Describe yourself",
                                  hintStyle: CustomTextStyles.textField,
                                  errorStyle: CustomTextStyles.errorText,
                                ),
                                validator: RequiredValidator(errorText: "Required"),
                              ),
                              SizedBox(height: 20),
                              Text(
                                'Description ( optional & 2MB Max )',
                                style: CustomTextStyles.mediumText,
                              ),
                              SizedBox(height: 20),
                              CustomButton(
                                onPressed: () async {
                                  FilePickerResult result = await FilePicker.platform.pickFiles();
                                  if (result != null) {
                                    _requestModel.document = result.files.single.path;
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                  }
                                },
                                width: 160,
                                color: CustomColors.primaryColor,
                                child: Text(
                                  'Add a document',
                                  style: CustomTextStyles.mediumWhiteText,
                                ),
                              )
                            ],
                          ),
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
            if (_formkey.currentState.validate()) {
              _requestModel.address = addressController.text.trim();
              _requestModel.description = descriptionController.text.trim();
              _requestModel.priceRangeFrom = double.parse((priceFromController.text.trim()));
              _requestModel.priceRangeTo = double.parse((priceToController.text.trim()));
              _requestModel.timeRangeFrom = timeFromController.text.trim();
              _requestModel.timeRangeTo = timeToController.text.trim();
              _requestModel.lat = selectedLocation.lat;
              _requestModel.lng = selectedLocation.lng;
              inspect(_requestModel);
              _serviceProviderBloc.add(CreateServiceProvider(request: _requestModel));
            }
          },
          child: BlocBuilder<CreateServiceProviderBloc, CreateServiceProviderState>(
            bloc: _serviceProviderBloc,
            builder: (context, state) {
              if (state is CreateServiceProviderFailed) {
                return Text('Failed');
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
                return Icon(
                  Icons.add,
                  color: Colors.white,
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
