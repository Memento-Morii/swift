import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:swift/helper/colors.dart';
import 'package:swift/helper/text_styles.dart';
import 'package:swift/models/user_model.dart';
import 'package:swift/widgets/navigator_drawers.dart';
import 'package:swift/widgets/profile_textfield.dart';

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
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
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
                      Center(
                        child: Container(
                          height: 120,
                          width: 120,
                          decoration: BoxDecoration(
                            color: CustomColors.customGreen,
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      Text(
                        'First Name',
                        style: CustomTextStyles.boldText,
                      ),
                      ProfileTextField(
                        initalName: user.firstName,
                      ),
                      Text(
                        'Last Name',
                        style: CustomTextStyles.boldText,
                      ),
                      ProfileTextField(
                        initalName: user.lastName,
                      ),
                      Text(
                        'Email',
                        style: CustomTextStyles.boldText,
                      ),
                      ProfileTextField(
                        initalName: user.email,
                      ),
                      Text(
                        'Your Phone',
                        style: CustomTextStyles.boldText,
                      ),
                      ProfileTextField(
                        initalName: user.phoneNumber,
                      ),
                      Text(
                        'Site Number',
                        style: CustomTextStyles.boldText,
                      ),
                      ProfileTextField(
                        initalName: user.siteName,
                      ),
                      Text(
                        'Block Number',
                        style: CustomTextStyles.boldText,
                      ),
                      ProfileTextField(
                        initalName: user.blockNumber,
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
      ),
    );
  }
}
