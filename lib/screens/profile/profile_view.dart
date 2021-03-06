import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:swift/helper/text_styles.dart';
import 'package:swift/helper/utils.dart';
import 'package:swift/models/user_model.dart';
import 'package:swift/screens/edit_profile/edit_profile_view.dart';
import 'package:swift/widgets/navigator_drawers.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
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
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context).profile.toUpperCase(),
          style: CustomTextStyles.bigWhiteText,
        ),
      ),
      body: Utils.exitDialog(
        context: context,
        child: BlocProvider(
          create: (context) => ProfileBloc(),
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
                      height: MediaQuery.of(context).size.height * 0.45,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: user.userImage == null
                              ? AssetImage("assets/profile-user.png")
                              : MemoryImage(
                                  Base64Decoder().convert(user.userImage),
                                ),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                        child: Stack(
                          children: [
                            Positioned(
                              top: 10,
                              right: 10,
                              child: IconButton(
                                icon: Icon(
                                  Icons.edit,
                                  color: Colors.black,
                                ),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => EditProfile(user),
                                    ),
                                  );
                                },
                              ),
                            ),
                            Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  CircleAvatar(
                                    backgroundColor: Colors.white,
                                    radius: 80,
                                    backgroundImage: user.userImage == null
                                        ? AssetImage("assets/profile-user.png")
                                        : MemoryImage(
                                            Base64Decoder().convert(user.userImage),
                                          ),
                                  ),
                                  SizedBox(height: 20),
                                  Row(
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
                                  Text(
                                    user.email,
                                    style: CustomTextStyles.textField,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            AppLocalizations.of(context).houseInfo,
                            style: CustomTextStyles.coloredBold,
                          ),
                          SizedBox(height: 20),
                          Text(
                            AppLocalizations.of(context).blockNumber,
                            style: CustomTextStyles.boldMediumText,
                          ),
                          Text(
                            user.blockNumber,
                            style: CustomTextStyles.coloredBold,
                          ),
                          SizedBox(height: 20),
                          Text(
                            AppLocalizations.of(context).houseNo,
                            style: CustomTextStyles.boldMediumText,
                          ),
                          Text(
                            user.houseNumber,
                            style: CustomTextStyles.coloredBold,
                          ),
                          SizedBox(height: 20),
                          Text(
                            AppLocalizations.of(context).siteName,
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
                return Center(
                  child: Text(
                    AppLocalizations.of(context).failed,
                    style: CustomTextStyles.bigErrorText,
                  ),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
