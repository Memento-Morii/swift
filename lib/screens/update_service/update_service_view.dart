import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:swift/helper/colors.dart';
import 'package:swift/helper/text_styles.dart';
import 'package:swift/models/my_services_model.dart';
import 'package:swift/screens/my_services/my_services_view.dart';
import 'package:swift/screens/update_service/bloc/update_service_bloc.dart';
import 'package:swift/widgets/custom_button.dart';

// ignore: must_be_immutable
class UpdateServiceView extends StatefulWidget {
  UpdateServiceView(this.myService);
  MyServicesModel myService;
  @override
  _UpdateServiceViewState createState() => _UpdateServiceViewState();
}

class _UpdateServiceViewState extends State<UpdateServiceView> {
  RangeValues selectedPriceRanges = RangeValues(100, 900);
  RangeValues selectedTimeRanges = RangeValues(100, 900);
  TextEditingController addressController = TextEditingController();
  UpdateServiceBloc _updateServiceBloc;
  @override
  void initState() {
    _updateServiceBloc = UpdateServiceBloc();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          'UPDATE MY SERVICES',
          style: CustomTextStyles.bigWhiteText,
        ),
      ),
      body: BlocProvider(
        create: (context) => UpdateServiceBloc(),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(15, 20, 15, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Address',
                style: CustomTextStyles.mediumText,
              ),
              TextField(
                controller: addressController,
                style: CustomTextStyles.textField,
              ),
              SizedBox(height: 20),
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
      ),
      bottomNavigationBar: Container(
        margin: EdgeInsets.all(10),
        height: 50,
        child: CustomButton(
          onPressed: () {
            widget.myService.priceRangeFrom = selectedPriceRanges.start.round();
            widget.myService.priceRangeTo = selectedPriceRanges.end.round();
            _updateServiceBloc.add(UpdateMyService(context: context, myService: widget.myService));
          },
          color: CustomColors.primaryColor,
          child: BlocBuilder<UpdateServiceBloc, UpdateServiceState>(
            bloc: _updateServiceBloc,
            builder: (context, state) {
              if (state is UpdateServiceInitial) {
                return Text(
                  'Update',
                  style: CustomTextStyles.mediumWhiteText,
                );
              } else if (state is UpdateServiceLoading) {
                return SizedBox(
                  height: 20,
                  width: 20,
                  child: Center(
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    ),
                  ),
                );
              } else {
                return Text(
                  'Failed',
                  style: CustomTextStyles.mediumWhiteText,
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
