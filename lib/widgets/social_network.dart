import 'package:flutter/material.dart';
import 'package:swift/helper/utils.dart';

enum URL_TYPE {
  Telephone,
  Link,
  SMS,
}

class SocialNetwork extends StatelessWidget {
  final String icon;
  final String url;
  final URL_TYPE urlType;
  const SocialNetwork({
    Key key,
    @required this.icon,
    @required this.url,
    @required this.urlType,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        Utils.openLink(url: url, urlType: urlType);
      },
      child: Image.asset(
        icon,
        height: 40,
      ),
    );
  }
}
