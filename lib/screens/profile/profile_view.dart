import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:swift/helper/text_styles.dart';
import 'package:swift/models/user_model.dart';
import 'package:swift/widgets/navigator_drawers.dart';

import 'bloc/profile_bloc.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  ProfileBloc _profileBloc;
  @override
  void initState() {
    _profileBloc = ProfileBloc();
    _profileBloc.add(FetchProfile());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavigatorDrawer(),
      appBar: AppBar(),
      body: BlocProvider(
        create: (context) => ProfileBloc(),
        child: SingleChildScrollView(
          child: BlocBuilder<ProfileBloc, ProfileState>(
            bloc: _profileBloc,
            builder: (context, state) {
              if (state is ProfileInitial) {
                return Center(child: CircularProgressIndicator());
              } else if (state is ProfileLoaded) {
                UserModel user = state.userModel;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      color: Colors.black,
                      height: MediaQuery.of(context).size.height * 0.45,
                      child: Stack(
                        children: [
                          Positioned(
                            top: 20,
                            right: 20,
                            child: IconButton(
                              icon: Icon(
                                Icons.edit,
                                color: Colors.white,
                              ),
                              onPressed: () {},
                            ),
                          ),
                          Center(
                            child: Container(
                              height: 140,
                              width: 140,
                              decoration: BoxDecoration(
                                color: Colors.grey,
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                          Positioned(
                            left: 135,
                            bottom: 40,
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Text(
                                  user.firstName,
                                  style: CustomTextStyles.bigWhiteText,
                                ),
                                SizedBox(width: 10),
                                Text(
                                  user.lastName,
                                  style: CustomTextStyles.normalWhiteText,
                                ),
                              ],
                            ),
                          ),
                          Positioned(
                            left: 125,
                            bottom: 15,
                            child: Text(
                              user.email,
                              style: CustomTextStyles.textField,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'House Information',
                            style: CustomTextStyles.coloredBold,
                          ),
                          SizedBox(height: 20),
                          Text(
                            'Block Number',
                            style: CustomTextStyles.boldMediumText,
                          ),
                          Text(
                            user.blockNumber,
                            style: CustomTextStyles.coloredBold,
                          ),
                          SizedBox(height: 20),
                          Text(
                            'House Number',
                            style: CustomTextStyles.boldMediumText,
                          ),
                          Text(
                            user.houseNumber,
                            style: CustomTextStyles.coloredBold,
                          ),
                          SizedBox(height: 20),
                          Text(
                            'Site Number',
                            style: CustomTextStyles.boldMediumText,
                          ),
                          Text(
                            user.siteName,
                            style: CustomTextStyles.coloredBold,
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              } else {
                return Center(child: Text("Failed"));
              }
            },
          ),
        ),
      ),
    );
  }
}
