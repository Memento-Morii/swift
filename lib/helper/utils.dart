import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:swift/helper/text_styles.dart';

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
          height: 70,
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
}
