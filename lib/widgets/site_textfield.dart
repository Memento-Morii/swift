import 'package:flutter/material.dart';
import 'package:swift/helper/text_styles.dart';
import 'package:swift/helper/utils.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SiteTextField extends StatefulWidget {
  SiteTextField({
    this.initalName,
    this.siteController,
    this.onSuggestionSelected,
  });
  final String initalName;
  final TextEditingController siteController;
  final Function onSuggestionSelected;

  @override
  _SiteTextFieldState createState() => _SiteTextFieldState();
}

class _SiteTextFieldState extends State<SiteTextField> {
  bool isDisabled;
  @override
  void initState() {
    isDisabled = true;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      padding: EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(5),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: MediaQuery.of(context).size.width * 0.7,
            child: isDisabled
                ? Padding(
                    padding: EdgeInsets.only(left: 20),
                    child: Text(
                      widget.initalName,
                      style: CustomTextStyles.mediumText,
                    ),
                  )
                : Utils.siteNameWidget(
                    color: Colors.transparent,
                    hintext: AppLocalizations.of(context).searchForLocation,
                    onSuggestionSelected: widget.onSuggestionSelected,
                    siteController: widget.siteController,
                  ),
          ),
          IconButton(
            icon: Icon(
              Icons.edit,
              color: isDisabled ? Colors.grey : Colors.black,
            ),
            onPressed: () {
              setState(() {
                isDisabled = !isDisabled;
              });
            },
          ),
        ],
      ),
    );
  }
}
