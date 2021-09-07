import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:swift/helper/text_styles.dart';
import 'package:swift/l10n/l10n.dart';
import 'package:swift/provider/local_provider.dart';

class LanguageView extends StatefulWidget {
  @override
  _LanguageViewState createState() => _LanguageViewState();
}

class _LanguageViewState extends State<LanguageView> {
  int _selected;
  @override
  void initState() {
    super.initState();
  }

  List<String> names = ['English', 'አማርኛ'];
  @override
  Widget build(BuildContext context) {
    int localeIndex = Provider.of<LocalProvider>(context, listen: false).localeIndex;
    _selected = localeIndex;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context).language.toUpperCase(),
          style: CustomTextStyles.bigWhiteText,
        ),
        actions: [
          TextButton(
            onPressed: () {
              Locale locale = L10n.all[_selected];
              final provider = Provider.of<LocalProvider>(context, listen: false);
              provider.setLocale(locale, _selected);
            },
            child: Text(
              AppLocalizations.of(context).save,
              style: CustomTextStyles.mediumWhiteText,
            ),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: 2,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              final provider = Provider.of<LocalProvider>(context, listen: false);
              provider.localeIndex = index;
              setState(() {
                _selected = index;
              });
            },
            child: Container(
              padding: EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    names[index],
                    style: CustomTextStyles.boldTitleText,
                  ),
                  _selected == index ? Icon(Icons.check, color: Colors.green) : SizedBox()
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
