import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  CustomButton({
    this.child,
    this.onPressed,
    this.height = 50,
    this.horizontalPadding = 10,
    // this.width = 100,
    this.color,
  });
  final Widget child;
  final Function onPressed;
  final double height;
  final double horizontalPadding;
  // final double width;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Theme(
        data: ThemeData(shadowColor: color),
        child: Material(
          elevation: 7,
          color: color,
          borderRadius: BorderRadius.circular(10),
          child: Container(
            height: height,
            padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
            child: TextButton(
              onPressed: onPressed,
              child: child,
            ),
          ),
        ),
      ),
    );
  }
}
