import 'package:custom_radio_grouped_button/custom_radio_grouped_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:swift/helper/colors.dart';
import 'package:swift/helper/text_styles.dart';
import 'package:swift/models/service_model.dart';
import 'package:swift/screens/register/add_services/bloc/add_service_bloc.dart';
import 'package:swift/services/repositories.dart';
import 'package:swift/widgets/category_card.dart';

class AddService extends StatefulWidget {
  @override
  _AddServiceState createState() => _AddServiceState();
}

class _AddServiceState extends State<AddService> {
  RangeValues selectedPriceRanges = RangeValues(100, 800);
  RangeValues selectedTimeRanges = RangeValues(100, 900);
  AddServiceBloc _serviceBloc;
  List<String> categoryNames = [];
  @override
  void initState() {
    _serviceBloc = AddServiceBloc();
    _serviceBloc.add(FetchServices());
    super.initState();
  }

  getServiceName(ServiceModel _service) {
    List<String> names = [];
    _service.results.forEach((element) {
      names.add(element.name);
    });
    return names;
  }

  getCategories({ServiceModel service, String name}) {
    categoryNames.clear();
    service.results.forEach((element) {
      if (element.name == name) {
        element.serviceCategories.forEach((element) {
          categoryNames.add(element.name);
        });
      }
    });
    return categoryNames;
  }

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
                              getCategories(
                                  service: state.service, name: value);
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
                        categoryNames.length == 0
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
                                itemCount: categoryNames.length,
                                itemBuilder: (context, index) {
                                  return CategoryCard(categoryNames[index]);
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
      floatingActionButton: FloatingActionButton(
        backgroundColor: CustomColors.primaryColor,
        onPressed: () {},
        child: Icon(Icons.add),
      ),
    );
  }
}
