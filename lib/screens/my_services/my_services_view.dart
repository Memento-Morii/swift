import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:swift/helper/text_styles.dart';
import 'package:swift/models/my_services_model.dart';
import 'package:swift/screens/register/add_services/add_services_view.dart';
import 'package:swift/widgets/my_services_card.dart';
import 'package:swift/widgets/navigator_drawers.dart';

import 'bloc/my_services_bloc.dart';

class MyServices extends StatefulWidget {
  @override
  _MyServicesState createState() => _MyServicesState();
}

class _MyServicesState extends State<MyServices> {
  MyServicesBloc _myServicesBloc;
  @override
  void initState() {
    _myServicesBloc = MyServicesBloc();
    _myServicesBloc.add(FetchMyServices());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavigatorDrawer(),
      appBar: AppBar(
        title: Text(
          'MY SERVICES',
          style: CustomTextStyles.bigWhiteText,
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddService(true),
                ),
              );
            },
            child: Text(
              'Add',
              style: CustomTextStyles.mediumWhiteText,
            ),
          ),
        ],
      ),
      body: BlocProvider(
        create: (context) => MyServicesBloc(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: Center(
            child: BlocBuilder<MyServicesBloc, MyServicesState>(
              bloc: _myServicesBloc,
              builder: (context, state) {
                if (state is MyServicesInitial) {
                  return CircularProgressIndicator();
                } else if (state is MyServicesLoaded) {
                  List<MyServicesModel> myServices = state.myServices;
                  return ListView.separated(
                    itemCount: myServices.length,
                    itemBuilder: (context, index) {
                      MyServicesModel myService = myServices[index];
                      return MyServicesCard(myService);
                    },
                    separatorBuilder: (context, index) {
                      return SizedBox(height: 20);
                    },
                  );
                } else {
                  return Text(
                    'Failed',
                    style: CustomTextStyles.errorText,
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
