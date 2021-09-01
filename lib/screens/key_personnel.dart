import 'package:flutter/material.dart';
import 'package:swift/helper/text_styles.dart';
import 'package:swift/widgets/personnel_card.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class KeyPersonnel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context).keyPersonnel,
          style: CustomTextStyles.bigWhiteText,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              PersonnelCard(
                name: AppLocalizations.of(context).daniel,
                title: AppLocalizations.of(context).danielTitle,
                imgUrl: "assets/daniel.jpg",
                instaLink: "https://www.instagram.com/danielabera_haile/",
                linkedIn: "https://www.linkedin.com/in/danielaberahaile",
                fbLink: "https://www.facebook.com/DanielAberaHaile/",
                telegramLink: "https://t.me/DanielAberaHaile",
                twitterLink: "https://twitter.com/Daniel_A_Haile",
                tiktokLink: "https://tiktok.com/@danielaberahaile",
              ),
              SizedBox(height: 30),
              PersonnelCard(
                name: AppLocalizations.of(context).andualem,
                title: AppLocalizations.of(context).andualemTitle,
                imgUrl: "assets/andualem.jpg",
                instaLink: "https://instagram.com/andualem_yosef",
                linkedIn: "https://www.linkedin.com/in/andualemyosef",
                fbLink: "https://www.facebook.com/profile.php?id=100009126510882",
                telegramLink: "https://t.me/Andualem_Yosef",
                twitterLink: "https://twitter.com/YosefAndualem",
                tiktokLink: "http://tiktok.com/@Andualem_Yosef",
              ),
              SizedBox(height: 30),
              PersonnelCard(
                name: AppLocalizations.of(context).birhane,
                title: AppLocalizations.of(context).birhaneTitle,
                imgUrl: "assets/birhane.jpg",
                instaLink: "",
                linkedIn: "",
                fbLink: "",
                telegramLink: "",
                twitterLink: "",
                tiktokLink: "",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
