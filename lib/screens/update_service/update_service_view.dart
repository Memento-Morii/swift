import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:swift/helper/colors.dart';
import 'package:swift/helper/text_styles.dart';
import 'package:swift/models/my_services_model.dart';
import 'package:swift/screens/my_services/my_services_view.dart';
import 'package:swift/screens/update_service/bloc/update_service_bloc.dart';
import 'package:swift/widgets/custom_button.dart';
import 'package:swift/widgets/range_field.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

// ignore: must_be_immutable
class UpdateServiceView extends StatefulWidget {
  UpdateServiceView(this.myService);
  MyServicesModel myService;
  @override
  _UpdateServiceViewState createState() => _UpdateServiceViewState();
}

class _UpdateServiceViewState extends State<UpdateServiceView> {
  TextEditingController addressController = TextEditingController();
  UpdateServiceBloc _updateServiceBloc;
  @override
  void initState() {
    _updateServiceBloc = UpdateServiceBloc();
    super.initState();
  }

  TextEditingController priceFromController = TextEditingController();
  TextEditingController priceToController = TextEditingController();
  TextEditingController timeFromController = TextEditingController();
  TextEditingController timeToController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  GlobalKey<FormState> _formkey = GlobalKey<FormState>();

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
          AppLocalizations.of(context).updateService,
          style: CustomTextStyles.bigWhiteText,
        ),
      ),
      body: BlocProvider(
        create: (context) => UpdateServiceBloc(),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(15, 20, 15, 0),
          child: Form(
            key: _formkey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  AppLocalizations.of(context).address,
                  style: CustomTextStyles.mediumText,
                ),
                TextFormField(
                  initialValue: widget.myService.address,
                  style: CustomTextStyles.textField,
                  onChanged: (value) {
                    widget.myService.address = value;
                  },
                ),
                SizedBox(height: 20),
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
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Container(
        margin: EdgeInsets.all(10),
        height: 50,
        child: CustomButton(
          onPressed: () {
            if (_formkey.currentState.validate()) {
              widget.myService.priceRangeFrom = double.parse((priceFromController.text.trim()));
              widget.myService.priceRangeTo = double.parse((priceToController.text.trim()));
              widget.myService.timeRangeFrom = timeFromController.text.trim();
              widget.myService.timeRangeTo = timeToController.text.trim();
              _updateServiceBloc
                  .add(UpdateMyService(context: context, myService: widget.myService));
            }
          },
          color: CustomColors.primaryColor,
          child: BlocBuilder<UpdateServiceBloc, UpdateServiceState>(
            bloc: _updateServiceBloc,
            builder: (context, state) {
              if (state is UpdateServiceInitial) {
                return Text(
                  AppLocalizations.of(context).update,
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
                  AppLocalizations.of(context).failed,
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
