import 'package:flutter/material.dart';
import 'package:swift/helper/colors.dart';
import 'package:swift/helper/text_styles.dart';
import 'package:swift/widgets/social_network.dart';

class PersonnelCard extends StatelessWidget {
  PersonnelCard({
    this.name,
    this.title,
    this.telegramLink,
    this.instaLink,
    this.fbLink,
    this.linkedIn,
    this.tiktokLink,
    this.twitterLink,
    this.imgUrl,
  });
  final String name;
  final String title;
  final String telegramLink;
  final String instaLink;
  final String fbLink;
  final String linkedIn;
  final String tiktokLink;
  final String twitterLink;
  final String imgUrl;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Material(
          elevation: 10,
          borderRadius: BorderRadius.circular(20),
          color: CustomColors.primaryColor,
          child: Container(
            padding: EdgeInsets.all(10),
            child: Row(
              children: <Widget>[
                CircleAvatar(
                  radius: 50,
                  backgroundColor: Colors.white,
                  backgroundImage: AssetImage(imgUrl),
                ),
                SizedBox(width: 10),
                Column(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.greenAccent[400],
                        border: Border.all(
                          color: Colors.white,
                          width: 1.5,
                        ),
                      ),
                      child: Text(
                        name,
                        style: CustomTextStyles.mediumWhiteText,
                      ),
                    ),
                    SizedBox(height: 20),
                    Container(
                      width: 200,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: EdgeInsets.all(5),
                      child: Center(
                        child: Text(
                          title,
                          style: CustomTextStyles.boldTitleText,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 20),
        Container(
          height: 40,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              SocialNetwork(
                icon: "assets/telegram.png",
                url: telegramLink,
                urlType: URL_TYPE.Link,
              ),
              SizedBox(width: 15),
              SocialNetwork(
                icon: "assets/instagram.png",
                url: instaLink,
                urlType: URL_TYPE.Link,
              ),
              SizedBox(width: 15),
              SocialNetwork(
                icon: "assets/facebook.png",
                url: fbLink,
                urlType: URL_TYPE.Link,
              ),
              SizedBox(width: 15),
              SocialNetwork(
                icon: "assets/linkedin.png",
                url: linkedIn,
                urlType: URL_TYPE.Link,
              ),
              SizedBox(width: 15),
              SocialNetwork(
                icon: "assets/tiktok.png",
                url: tiktokLink,
                urlType: URL_TYPE.Link,
              ),
              SizedBox(width: 15),
              SocialNetwork(
                icon: "assets/twitter.png",
                url: twitterLink,
                urlType: URL_TYPE.Link,
              ),
            ],
          ),
        )
      ],
    );
  }
}
