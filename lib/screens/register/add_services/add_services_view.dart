import 'package:custom_radio_grouped_button/custom_radio_grouped_button.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:swift/helper/colors.dart';
import 'package:swift/helper/text_styles.dart';
import 'package:swift/helper/utils.dart';
import 'package:swift/models/location_model.dart';
import 'package:swift/models/service_model.dart';
import 'package:swift/models/service_provider_request_model.dart';
import 'package:swift/screens/home/home_view.dart';
import 'package:swift/screens/my_services/my_services_view.dart';
import 'package:swift/screens/register/add_services/bloc/add_service_bloc.dart';
import 'package:swift/screens/register/add_services/bloc/create_service_provider_bloc.dart';
import 'package:swift/services/repositories.dart';
import 'package:swift/widgets/category_card.dart';
import 'package:swift/widgets/custom_button.dart';
import 'package:swift/widgets/range_field.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AddService extends StatefulWidget {
  AddService(this.isAnother);
  final bool isAnother;
  @override
  _AddServiceState createState() => _AddServiceState();
}

class _AddServiceState extends State<AddService> {
  AddServiceBloc _serviceBloc;
  CreateServiceProviderBloc _serviceProviderBloc;
  ServiceProviderRequest _requestModel = ServiceProviderRequest();
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
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => MyServices(),
                ),
                (Route<dynamic> route) => false,
              );
            },
          ),
          title: Text(
            AppLocalizations.of(context).addService.toUpperCase(),
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
                      ? Utils.showToast(
                          context,
                          false,
                          AppLocalizations.of(context).addNewService,
                          2,
                        )
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
                                    hintText: AppLocalizations.of(context).searchForLocation,
                                    hintStyle: CustomTextStyles.textField,
                                  ),
                                ),
                                suggestionsCallback: (pattern) async {
                                  return await Repositories().searchLocation(pattern);
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
                                AppLocalizations.of(context).priceRange,
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
                                    AppLocalizations.of(context).to,
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
                                AppLocalizations.of(context).timeRange,
                                style: CustomTextStyles.mediumText,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: <Widget>[
                                  RangeField(controller: timeFromController),
                                  Text(
                                    AppLocalizations.of(context).to,
                                    style: CustomTextStyles.boldTitleText,
                                  ),
                                  RangeField(controller: timeToController),
                                ],
                              ),
                              SizedBox(height: 30),
                              Text(
                                AppLocalizations.of(context).description,
                                style: CustomTextStyles.mediumText,
                              ),
                              TextFormField(
                                style: CustomTextStyles.textField,
                                controller: descriptionController,
                                decoration: InputDecoration(
                                  // hintText: "Describe yourself",
                                  hintStyle: CustomTextStyles.textField,
                                  errorStyle: CustomTextStyles.bigErrorText,
                                ),
                                validator: RequiredValidator(
                                  errorText: AppLocalizations.of(context).required,
                                ),
                              ),
                              SizedBox(height: 20),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    '${AppLocalizations.of(context).document} (${AppLocalizations.of(context).optional} & ${AppLocalizations.of(context).notTwoMb})',
                                    style: CustomTextStyles.mediumText,
                                  ),
                                  IconButton(
                                    icon: Icon(Icons.upload_file),
                                    onPressed: () async {
                                      FilePickerResult result = await FilePicker.platform.pickFiles(
                                        allowMultiple: false,
                                        // allowedExtensions: ['pdf'],
                                      );
                                      if (result != null) {
                                        _requestModel.document = result.files.single;
                                      } else {
                                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                      }
                                    },
                                  ),
                                ],
                              ),
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
        floatingActionButton: Container(
          height: 60,
          child: CustomButton(
            width: 180,
            color: CustomColors.primaryColor,
            onPressed: () async {
              if (_formkey.currentState.validate()) {
                if (selectedLocation != null) {
                  _requestModel.address = addressController.text.trim();
                  _requestModel.description = descriptionController.text.trim();
                  _requestModel.priceRangeFrom = double.parse((priceFromController.text.trim()));
                  _requestModel.priceRangeTo = double.parse((priceToController.text?.trim()));
                  _requestModel.timeRangeFrom = timeFromController.text.trim();
                  _requestModel.timeRangeTo = timeToController.text.trim();
                  _requestModel.lat = selectedLocation.lat;
                  _requestModel.lng = selectedLocation.lng;
                  _serviceProviderBloc.add(CreateServiceProvider(request: _requestModel));
                } else {
                  Utils.showToast(context, true, AppLocalizations.of(context).selectLocation, 2);
                }
              }
            },
            child: BlocBuilder<CreateServiceProviderBloc, CreateServiceProviderState>(
              bloc: _serviceProviderBloc,
              builder: (context, state) {
                if (state is CreateServiceProviderFailed) {
                  return Text(
                    AppLocalizations.of(context).failed,
                    style: CustomTextStyles.mediumWhiteText,
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
                  return Text(
                    AppLocalizations.of(context).add,
                    style: CustomTextStyles.mediumWhiteText,
                  );
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
