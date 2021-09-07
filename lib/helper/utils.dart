import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:swift/helper/text_styles.dart';
import 'package:swift/models/location_model.dart';
import 'package:swift/screens/register/signIn_view.dart';
import 'package:swift/services/repositories.dart';
import 'package:swift/widgets/social_network.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'colors.dart';

class Utils {
  static showToast(BuildContext context, bool isError, String message, int duration) {
    return showToastWidget(
      Material(
        elevation: 10,
        color: isError == null
            ? Colors.grey[400]
            : isError
                ? Colors.red
                : Colors.green,
        borderRadius: BorderRadius.circular(50),
        child: Container(
          height: 80,
          padding: EdgeInsets.fromLTRB(20, 20, 10, 10),
          width: MediaQuery.of(context).size.width * 0.8,
          child: Text(
            message,
            style: CustomTextStyles.mediumWhiteText,
          ),
        ),
      ),
      context: context,
      animation: StyledToastAnimation.slideFromTop,
      reverseAnimation: StyledToastAnimation.slideToTop,
      position: StyledToastPosition.top,
      startOffset: Offset(0.0, -3.0),
      reverseEndOffset: Offset(0.0, -3.0),
      duration: Duration(seconds: duration),
      animDuration: Duration(seconds: 1),
      curve: Curves.elasticOut,
      reverseCurve: Curves.fastOutSlowIn,
    );
  }

  static Future openLink({@required String url, @required URL_TYPE urlType}) async =>
      await _launchUrl(url, urlType);

  static Future _launchUrl(String url, URL_TYPE urlType) async {
    String finalLink;
    switch (urlType) {
      case URL_TYPE.Link:
        finalLink = url;
        break;
      case URL_TYPE.SMS:
        finalLink = 'sms:$url';
        break;
      case URL_TYPE.Telephone:
        finalLink = 'tel:$url';
        break;
      default:
    }
    if (await canLaunch(finalLink)) {
      await launch(finalLink);
    } else {
      print("error");
    }
  }

  static Widget siteNameWidget({
    TextEditingController siteController,
    Function onSuggestionSelected,
    Color color,
    String hintext,
  }) {
    return TypeAheadField<LocationModel>(
      textFieldConfiguration: TextFieldConfiguration(
        controller: siteController,
        style: CustomTextStyles.textField,
        decoration: InputDecoration(
          hintText: hintext,
          hintStyle: CustomTextStyles.boldText,
          contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 20.0),
          border: OutlineInputBorder(
            borderSide: BorderSide(
              width: 3,
              color: color,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              width: 2,
              color: color,
            ),
          ),
        ),
      ),
      suggestionsCallback: (pattern) async {
        return await Repositories().searchLocation(pattern);
      },
      itemBuilder: (context, itemData) {
        return ListTile(
            title: Text(
          itemData.name,
          style: CustomTextStyles.boldMediumText,
        ));
      },
      onSuggestionSelected: onSuggestionSelected,
    );
  }

  static Widget exitDialog({BuildContext context, Widget child}) {
    return WillPopScope(
      child: child,
      onWillPop: () async => showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(
            AppLocalizations.of(context).quit,
            style: CustomTextStyles.boldTitleText,
          ),
          actions: <Widget>[
            TextButton(
              child: Text(
                AppLocalizations.of(context).no,
                style: CustomTextStyles.coloredBold,
              ),
              onPressed: () => Navigator.of(context).pop(false),
            ),
            TextButton(
              child: Text(
                AppLocalizations.of(context).yes,
                style: CustomTextStyles.bigErrorText,
              ),
              onPressed: () => Navigator.of(context).pop(true),
            ),
          ],
        ),
      ),
    );
  }

  static Future logoutDialog({BuildContext context, int selectedIndex}) {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          "${AppLocalizations.of(context).logout}?",
          style: CustomTextStyles.boldTitleText,
        ),
        actions: <Widget>[
          TextButton(
            child: Text(
              AppLocalizations.of(context).no,
              style: CustomTextStyles.coloredBold,
            ),
            onPressed: () => Navigator.of(context).pop(false),
          ),
          TextButton(
            child: Text(
              AppLocalizations.of(context).yes,
              style: CustomTextStyles.bigErrorText,
            ),
            onPressed: () async {
              SharedPreferences prefs = await SharedPreferences.getInstance();
              prefs.clear();
              selectedIndex = 0;
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => SignInView(),
                ),
                (Route<dynamic> route) => false,
              );
            },
          ),
        ],
      ),
    );
  }
}
