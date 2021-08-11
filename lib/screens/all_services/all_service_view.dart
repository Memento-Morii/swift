import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:swift/helper/colors.dart';
import 'package:swift/helper/text_styles.dart';
import 'package:swift/models/service_model.dart';
import 'package:swift/screens/register/add_services/bloc/add_service_bloc.dart';

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
          'ALL SERVICES',
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
                            color: Colors.greenAccent[400],
                            child: Text(
                              _service.name.toUpperCase(),
                              style: CustomTextStyles.boldTitleText,
                            ),
                          ),
                          SizedBox(height: 10),
                          ListView.separated(
                            shrinkWrap: true,
                            itemCount: _service.serviceCategories.length,
                            itemBuilder: (context, smallIndex) {
                              ServiceModel _categories = _service.serviceCategories[smallIndex];
                              return Container(
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    // borderRadius: BorderRadius.circular(10),
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
                                    Image.asset(
                                      "assets/mechanic.png",
                                      height: 50,
                                    ),
                                  ],
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
                return Center(child: Text('Failed'));
              }
            },
          ),
        ),
      ),
    );
  }
}
