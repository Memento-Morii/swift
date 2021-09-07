import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:swift/helper/colors.dart';
import 'package:swift/helper/text_styles.dart';
import 'package:swift/helper/utils.dart';
import 'package:swift/models/service_category_model.dart';
import 'package:swift/models/service_model.dart';
import 'package:swift/screens/all_services/all_service_view.dart';
import 'package:swift/screens/create_order/create_order_view.dart';
import 'package:swift/screens/home/all_services_bloc/get_all_services_bloc.dart';
import 'package:swift/screens/service_category/service_category.dart';
import 'package:swift/widgets/custom_network_image.dart';
import 'package:swift/widgets/navigator_drawers.dart';
import 'package:swift/widgets/service_card.dart';
import 'package:swift/widgets/social_network.dart';
import 'search_bloc/search_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
            AppLocalizations.of(context).home.toUpperCase(),
            style: CustomTextStyles.bigWhiteText,
          ),
        ),
        body: Utils.exitDialog(
          context: context,
          child: MultiBlocProvider(
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
                        hintText: AppLocalizations.of(context).searchForServices,
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
                                          itemCount: 12,
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
                                            padding: EdgeInsets.symmetric(horizontal: 5),
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
                                                AppLocalizations.of(context).viewAllServices,
                                                style: CustomTextStyles.normalWhiteText,
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: 20),
                                        Text(
                                          AppLocalizations.of(context).frequentServices,
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
                                                        builder: (context) => CreateOrderView(
                                                          serviceCategory:
                                                              state.frequentServices[index],
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                  child: CustomNetworkImage(
                                                    imgUrl: state.frequentServices[index].image,
                                                    width: 80,
                                                  ));
                                            },
                                            separatorBuilder: (context, index) {
                                              return SizedBox(width: 20);
                                            },
                                          ),
                                        ),
                                        SizedBox(height: 20),
                                        Center(
                                          child: Text(
                                            AppLocalizations.of(context).orderUsing,
                                            style: CustomTextStyles.coloredBold,
                                          ),
                                        ),
                                        SizedBox(height: 10),
                                        Center(
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: <Widget>[
                                              SocialNetwork(
                                                icon: "assets/phone_green.png",
                                                url: "+251113854444",
                                                urlType: URL_TYPE.Telephone,
                                              ),
                                              SizedBox(width: 20),
                                              SocialNetwork(
                                                icon: "assets/telegram.png",
                                                url: "https://t.me/SwiftOlioBot",
                                                urlType: URL_TYPE.Link,
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(height: 20),
                                        Center(
                                          child: Text(
                                            AppLocalizations.of(context).followUs,
                                            style: CustomTextStyles.coloredBold,
                                          ),
                                        ),
                                        SizedBox(height: 10),
                                        Container(
                                          height: 40,
                                          child: ListView(
                                            scrollDirection: Axis.horizontal,
                                            children: [
                                              SocialNetwork(
                                                icon: "assets/telegram.png",
                                                url: "https://t.me/SwiftOlio",
                                                urlType: URL_TYPE.Link,
                                              ),
                                              SizedBox(width: 15),
                                              SocialNetwork(
                                                icon: "assets/instagram.png",
                                                url: "https://instagram.com/swiftolio",
                                                urlType: URL_TYPE.Link,
                                              ),
                                              SizedBox(width: 15),
                                              SocialNetwork(
                                                icon: "assets/facebook.png",
                                                url: "https://facebook.com/SwiftOlio",
                                                urlType: URL_TYPE.Link,
                                              ),
                                              SizedBox(width: 15),
                                              SocialNetwork(
                                                icon: "assets/linkedin.png",
                                                url:
                                                    "https://www.linkedin.com/company/swift-installation-and-maintenance",
                                                urlType: URL_TYPE.Link,
                                              ),
                                              SizedBox(width: 15),
                                              SocialNetwork(
                                                icon: "assets/tiktok.png",
                                                url: "https://tiktok.com/@swiftolio",
                                                urlType: URL_TYPE.Link,
                                              ),
                                              SizedBox(width: 15),
                                              SocialNetwork(
                                                icon: "assets/twitter.png",
                                                url: "https://twitter.com/SwiftOlio",
                                                urlType: URL_TYPE.Link,
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              } else {
                                return Center(
                                  child: Text(
                                    AppLocalizations.of(context).failed,
                                    style: CustomTextStyles.bigErrorText,
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
                        } else if (state is SearchNotFound) {
                          return Text(
                            'Search Not Found',
                            style: CustomTextStyles.bigErrorText,
                          );
                        } else {
                          return Text(
                            'Error',
                            style: CustomTextStyles.bigErrorText,
                          );
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
