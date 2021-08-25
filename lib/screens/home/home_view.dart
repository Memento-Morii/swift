import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:swift/helper/colors.dart';
import 'package:swift/helper/text_styles.dart';
import 'package:swift/models/service_category_model.dart';
import 'package:swift/models/service_model.dart';
import 'package:swift/screens/all_services/all_service_view.dart';
import 'package:swift/screens/create_order/create_order_view.dart';
import 'package:swift/screens/home/all_services_bloc/get_all_services_bloc.dart';
import 'package:swift/screens/service_category/service_category.dart';
import 'package:swift/widgets/custom_network_image.dart';
import 'package:swift/widgets/navigator_drawers.dart';
import 'package:swift/widgets/service_card.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'search_bloc/search_bloc.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  GetAllServicesBloc _serviceBloc;
  SearchBloc _searchBloc;
  @override
  void initState() {
    _serviceBloc = GetAllServicesBloc();
    _searchBloc = SearchBloc();
    _serviceBloc.add(GetAllServices());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: NavigatorDrawer(),
        appBar: AppBar(
          title: Text(
            'HOME',
            style: CustomTextStyles.bigWhiteText,
          ),
        ),
        body: MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => GetAllServicesBloc(),
            ),
            BlocProvider(
              create: (context) => SearchBloc(),
            ),
          ],
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  TextFormField(
                    style: CustomTextStyles.textField,
                    onChanged: (searchTerm) {
                      _searchBloc.add(Search(searchTerm));
                    },
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
                  BlocBuilder<SearchBloc, SearchState>(
                    bloc: _searchBloc,
                    builder: (context, state) {
                      if (state is SearchInitial) {
                        return BlocBuilder<GetAllServicesBloc, GetAllServicesState>(
                          bloc: _serviceBloc,
                          builder: (context, state) {
                            if (state is GetAllServicesInitial) {
                              return Center(child: CircularProgressIndicator());
                            } else if (state is GotServices) {
                              return SingleChildScrollView(
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 10),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
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
                                          ServiceModel _result = state.allServices[index];
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
                                          itemCount: state.frequentServices.length,
                                          scrollDirection: Axis.horizontal,
                                          itemBuilder: (context, index) {
                                            return InkWell(
                                              onTap: () {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) => ServiceCategory(
                                                      serviceId: state.frequentServices[index].id,
                                                      name: state.frequentServices[index].name,
                                                    ),
                                                  ),
                                                );
                                              },
                                              child: ServiceCard(
                                                result: state.frequentServices[index],
                                                width: 80,
                                              ),
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
                              return Center(
                                child: Text(
                                  "Loaded",
                                  style: CustomTextStyles.errorText,
                                ),
                              );
                            }
                          },
                        );
                      } else if (state is SearchFound) {
                        List<ServiceCategoryModel> searchResults = state.searchResults;
                        return GridView.builder(
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 5,
                            mainAxisSpacing: 5,
                          ),
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: searchResults.length,
                          itemBuilder: (context, index) {
                            ServiceCategoryModel _result = searchResults[index];
                            return InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => CreateOrderView(
                                      serviceCategory: _result,
                                    ),
                                  ),
                                );
                              },
                              child: Column(
                                children: [
                                  CustomNetworkImage(
                                    imgUrl: _result.image,
                                    height: 100,
                                    width: 100,
                                  ),
                                  Text(
                                    _result.name,
                                    style: CustomTextStyles.boldTitleText,
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      } else if (state is Searching) {
                        return Center(child: CircularProgressIndicator());
                      } else {
                        return Text('error');
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
