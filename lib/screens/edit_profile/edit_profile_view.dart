import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:swift/helper/colors.dart';
import 'package:swift/helper/text_styles.dart';
import 'package:swift/models/user_model.dart';
import 'package:swift/widgets/custom_button.dart';
import 'package:swift/widgets/profile_textfield.dart';

import 'bloc/edit_profile_bloc.dart';

// ignore: must_be_immutable
class EditProfile extends StatefulWidget {
  EditProfile(this.user);
  UserModel user;
  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  EditProfileBloc _editProfileBloc;
  @override
  void initState() {
    _editProfileBloc = EditProfileBloc();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocProvider(
        create: (context) => EditProfileBloc(),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(10, 20, 20, 0),
            child: SingleChildScrollView(
              child: BlocBuilder<EditProfileBloc, EditProfileState>(
                bloc: _editProfileBloc,
                builder: (context, state) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'First Name',
                        style: CustomTextStyles.boldText,
                      ),
                      ProfileTextField(
                        initalName: widget.user.firstName,
                        onChanged: (value) {
                          widget.user.firstName = value;
                        },
                      ),
                      Text(
                        'Last Name',
                        style: CustomTextStyles.boldText,
                      ),
                      ProfileTextField(
                        initalName: widget.user.lastName,
                        onChanged: (value) {
                          widget.user.lastName = value;
                        },
                      ),
                      Text(
                        'House Number',
                        style: CustomTextStyles.boldText,
                      ),
                      ProfileTextField(
                        initalName: widget.user.houseNumber,
                        onChanged: (value) {
                          widget.user.houseNumber = value;
                        },
                      ),
                      Text(
                        'Site Name',
                        style: CustomTextStyles.boldText,
                      ),
                      ProfileTextField(
                        initalName: widget.user.siteName,
                        onChanged: (value) {
                          widget.user.siteName = value;
                        },
                      ),
                      Text(
                        'Block Number',
                        style: CustomTextStyles.boldText,
                      ),
                      ProfileTextField(
                        initalName: widget.user.blockNumber,
                        onChanged: (value) {
                          widget.user.blockNumber = value;
                        },
                      ),
                      SizedBox(height: 20),
                      CustomButton(
                        color: CustomColors.primaryColor,
                        onPressed: () {
                          _editProfileBloc.add(EditUserProfile(
                            editedUser: widget.user,
                            context: context,
                          ));
                        },
                        child: Text(
                          'Update',
                          style: CustomTextStyles.mediumWhiteText,
                        ),
                      )
                    ],
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
