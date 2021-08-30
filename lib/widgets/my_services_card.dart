import 'package:flutter/material.dart';
import 'package:swift/helper/text_styles.dart';
import 'package:swift/models/my_services_model.dart';
import 'package:swift/screens/update_service/update_service_view.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MyServicesCard extends StatelessWidget {
  MyServicesCard(this.myServices);
  final MyServicesModel myServices;
  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(20),
      elevation: 4,
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  myServices.serviceCategory.name,
                  style: CustomTextStyles.boldTitleText,
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => UpdateServiceView(myServices),
                      ),
                    );
                  },
                  child: Text(
                    AppLocalizations.of(context).update,
                    style: CustomTextStyles.coloredBold,
                  ),
                )
              ],
            ),
            Text(
              myServices.service.name,
              style: CustomTextStyles.boldText,
            ),
            SizedBox(height: 10),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  "${AppLocalizations.of(context).priceRangeFrom}  ",
                  style: CustomTextStyles.mediumText,
                ),
                Text(
                  myServices.priceRangeFrom.toString(),
                  style: CustomTextStyles.boldTitleText,
                ),
                Text(
                  "  ${AppLocalizations.of(context).to}  ",
                  style: CustomTextStyles.mediumText,
                ),
                Text(
                  myServices.priceRangeTo.toString(),
                  style: CustomTextStyles.boldTitleText,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
