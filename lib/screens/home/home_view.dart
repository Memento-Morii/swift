import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:swift/helper/colors.dart';
import 'package:swift/helper/text_styles.dart';
import 'package:swift/models/service_model.dart';
import 'package:swift/screens/register/add_services/bloc/add_service_bloc.dart';
import 'package:swift/widgets/navigator_drawers.dart';
import 'package:swift/widgets/service_card.dart';

class Home extends StatefulWidget {
  Home({this.response});
  final response;
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  AddServiceBloc _serviceBloc;
  @override
  void initState() {
    _serviceBloc = AddServiceBloc();
    _serviceBloc.add(FetchServices());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: NavigatorDrawer(),
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          iconTheme: IconThemeData(color: CustomColors.primaryColor),
        ),
        body: BlocProvider(
          create: (context) => AddServiceBloc(),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: BlocBuilder<AddServiceBloc, AddServiceState>(
              bloc: _serviceBloc,
              builder: (context, state) {
                if (state is AddServiceInitial) {
                  return Center(child: CircularProgressIndicator());
                } else if (state is AddServiceLoaded) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "Services",
                        style: CustomTextStyles.headlineText2,
                      ),
                      SizedBox(height: 20),
                      Container(
                        height: 100,
                        child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: state.service.results.length,
                          itemBuilder: (context, index) {
                            Result _result = state.service.results[index];
                            return ServiceCard(_result);
                          },
                        ),
                      )
                    ],
                  );
                } else {
                  return Text("Loaded");
                }
              },
            ),
          ),
        ));
  }
}
