import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';
import 'package:swift/helper/colors.dart';
import 'package:swift/helper/text_styles.dart';
import 'package:swift/l10n/l10n.dart';
import 'package:swift/models/service_model.dart';
import 'package:swift/provider/local_provider.dart';
import 'package:swift/screens/all_services/all_service_view.dart';
import 'package:swift/screens/register/add_services/bloc/add_service_bloc.dart';
import 'package:swift/screens/service_category/service_category.dart';
import 'package:swift/widgets/navigator_drawers.dart';
import 'package:swift/widgets/service_card.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Home extends StatefulWidget {
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
    // var location = Location();
    // location.getLocation().then((value) => print(value.latitude));
    return Scaffold(
        drawer: NavigatorDrawer(),
        appBar: AppBar(
          title: Text(
            'HOME',
            style: CustomTextStyles.bigWhiteText,
          ),
        ),
        body: BlocProvider(
          create: (context) => AddServiceBloc(),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
            child: BlocBuilder<AddServiceBloc, AddServiceState>(
              bloc: _serviceBloc,
              builder: (context, state) {
                if (state is AddServiceInitial) {
                  return Center(child: CircularProgressIndicator());
                } else if (state is AddServiceLoaded) {
                  return SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          TextFormField(
                            style: CustomTextStyles.textField,
                            decoration: InputDecoration(
                              prefixIcon: Icon(
                                Icons.search,
                                color: Colors.red,
                                size: 30,
                              ),
                              contentPadding: EdgeInsets.symmetric(vertical: 16, horizontal: 20.0),
                              border: OutlineInputBorder(
                                borderSide: BorderSide(),
                              ),
                              hintText: "Search for Services",
                              hintStyle: CustomTextStyles.textField,
                              fillColor: Colors.transparent,
                            ),
                          ),
                          SizedBox(height: 20),
                          GridView.builder(
                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 4,
                              crossAxisSpacing: 5,
                              mainAxisSpacing: 5,
                            ),
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: 8,
                            itemBuilder: (context, index) {
                              ServiceModel _result = state.service[index];
                              return InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ServiceCategory(
                                        serviceId: _result.id,
                                        name: _result.name,
                                      ),
                                    ),
                                  );
                                },
                                child: ServiceCard(result: _result),
                              );
                            },
                          ),
                          SizedBox(height: 20),
                          Center(
                            child: Container(
                              height: 40,
                              width: 200,
                              decoration: BoxDecoration(
                                color: CustomColors.primaryColor,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: TextButton(
                                onPressed: () {
                                  // Locale locale = L10n.all[0];
                                  // final provider =
                                  //     Provider.of<LocalProvider>(context, listen: false);
                                  // provider.setLocale(locale);
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => AllService(),
                                    ),
                                  );
                                },
                                child: Text(
                                  "View All Services",
                                  style: CustomTextStyles.normalWhiteText,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 20),
                          Text(
                            "Frequent Services",
                            style: CustomTextStyles.mediumText,
                          ),
                          SizedBox(height: 20),
                          Container(
                            height: 100,
                            child: ListView.separated(
                              shrinkWrap: true,
                              itemCount: 5,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                return ServiceCard(
                                  result: state.service[index],
                                  width: 80,
                                );
                              },
                              separatorBuilder: (context, index) {
                                return SizedBox(width: 20);
                              },
                            ),
                          ),
                          SizedBox(height: 20),
                          Center(
                            child: Text(
                              "ORDER USING",
                              style: CustomTextStyles.coloredBold,
                            ),
                          ),
                          SizedBox(height: 10),
                          Center(
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Image.asset(
                                  "assets/phone_green.png",
                                  height: 60,
                                ),
                                SizedBox(width: 20),
                                Image.asset(
                                  "assets/telegram.png",
                                  height: 60,
                                )
                              ],
                            ),
                          ),
                          SizedBox(height: 20),
                          Center(
                            child: Text(
                              "FOLLOW US",
                              style: CustomTextStyles.coloredBold,
                            ),
                          ),
                          SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            // mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Image.asset(
                                "assets/telegram.png",
                                height: 40,
                              ),
                              Image.asset(
                                "assets/instagram.png",
                                height: 40,
                              ),
                              Image.asset(
                                "assets/facebook.png",
                                height: 40,
                              ),
                              Image.asset(
                                "assets/whatsapp.png",
                                height: 40,
                              ),
                              Image.asset(
                                "assets/twitter.png",
                                height: 40,
                              ),
                              Image.asset(
                                "assets/tiktok.png",
                                height: 40,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
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
