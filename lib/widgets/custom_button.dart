import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  CustomButton(
      {this.child,
      this.onPressed,
      this.height = 50,
      this.width = 100,
      this.color});
  final Widget child;
  final Function onPressed;
  final double height;
  final double width;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(10),
        ),
        child: TextButton(
          style: ButtonStyle(
            elevation: MaterialStateProperty.all(12),
            shadowColor: MaterialStateProperty.all(color),
          ),
          onPressed: onPressed,
          child: child,
        ),
      ),
    );
  }
}
