import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:swift/helper/colors.dart';
import 'package:swift/helper/text_styles.dart';
import 'package:swift/helper/utils.dart';
import 'package:swift/models/location_model.dart';
import 'package:swift/models/user_model.dart';
import 'package:swift/screens/profile/profile_view.dart';
import 'package:swift/widgets/custom_button.dart';
import 'package:swift/widgets/profile_textfield.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:swift/widgets/site_textfield.dart';

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
  PlatformFile photo;
  @override
  void initState() {
    _editProfileBloc = EditProfileBloc();
    siteInital = widget.user.siteName;
    super.initState();
  }

  TextEditingController _siteController = TextEditingController();
  LocationModel _selectedLocation;
  String siteInital;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context).editProfile.toUpperCase(),
          style: CustomTextStyles.bigWhiteText,
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => Profile(),
              ),
              (Route<dynamic> route) => false,
            );
          },
        ),
      ),
      body: BlocProvider(
        create: (context) => EditProfileBloc(),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(10, 20, 20, 0),
            child: SingleChildScrollView(
              child: BlocListener<EditProfileBloc, EditProfileState>(
                bloc: _editProfileBloc,
                listener: (context, state) {
                  if (state is EditProfileSuccess) {
                    Utils.showToast(context, false, AppLocalizations.of(context).success, 2);
                  }
                  if (state is EditProfileFailed) {
                    Utils.showToast(context, true, state.message, 2);
                  }
                },
                child: BlocBuilder<EditProfileBloc, EditProfileState>(
                  bloc: _editProfileBloc,
                  builder: (context, state) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Center(
                          child: InkWell(
                            onTap: () async {
                              FilePickerResult result = await FilePicker.platform.pickFiles(
                                allowMultiple: false,
                              );
                              if (result != null) {
                                setState(() {
                                  photo = result.files.single;
                                });
                              }
                            },
                            child: CircleAvatar(
                              radius: 60,
                              backgroundImage: photo != null
                                  ? FileImage(File(photo.path))
                                  : widget.user.userImage == null
                                      ? AssetImage("assets/profile-user.png")
                                      : MemoryImage(
                                          Base64Decoder().convert(widget.user.userImage),
                                        ),
                            ),
                          ),
                        ),
                        Text(
                          AppLocalizations.of(context).firstName,
                          style: CustomTextStyles.boldText,
                        ),
                        ProfileTextField(
                          initalName: widget.user.firstName,
                          onChanged: (value) {
                            widget.user.firstName = value;
                          },
                        ),
                        Text(
                          AppLocalizations.of(context).lastName,
                          style: CustomTextStyles.boldText,
                        ),
                        ProfileTextField(
                          initalName: widget.user.lastName,
                          onChanged: (value) {
                            widget.user.lastName = value;
                          },
                        ),
                        Text(
                          AppLocalizations.of(context).houseNo,
                          style: CustomTextStyles.boldText,
                        ),
                        ProfileTextField(
                          initalName: widget.user.houseNumber,
                          onChanged: (value) {
                            widget.user.houseNumber = value;
                          },
                        ),
                        Text(
                          AppLocalizations.of(context).siteName,
                          style: CustomTextStyles.boldText,
                        ),
                        SiteTextField(
                          initalName: siteInital,
                          onSuggestionSelected: (suggestion) {
                            setState(() {
                              siteInital = suggestion.name;
                              _siteController.text = suggestion.name;
                              _selectedLocation = suggestion;
                            });
                          },
                          siteController: _siteController,
                        ),
                        Text(
                          AppLocalizations.of(context).blockNumber,
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
                              photo: photo,
                            ));
                          },
                          child: BlocBuilder<EditProfileBloc, EditProfileState>(
                            bloc: _editProfileBloc,
                            builder: (context, state) {
                              if (state is EditProfileLoading) {
                                return SizedBox(
                                  height: 20,
                                  width: 20,
                                  child: Center(
                                    child: CircularProgressIndicator(
                                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                                    ),
                                  ),
                                );
                              } else {
                                return Text(
                                  AppLocalizations.of(context).update,
                                  style: CustomTextStyles.mediumWhiteText,
                                );
                              }
                            },
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
      ),
    );
  }
}
