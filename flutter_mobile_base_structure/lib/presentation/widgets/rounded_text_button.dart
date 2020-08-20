import 'package:flutter/material.dart';

class RoundedTextButton extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;
  final TextStyle textStyle;
  final double bottomLeftRadius;
  final double bottomRightRadius;
  final double topLeftRadius;
  final double topRightRadius;
  final double allRadius;
  final Color backgroundColor;

  RoundedTextButton(
      {@required this.title,
      @required this.textStyle,
      @required this.onPressed,
      this.backgroundColor = Colors.grey,
      this.topLeftRadius = 0,
      this.bottomLeftRadius = 0,
      this.bottomRightRadius = 0,
      this.topRightRadius = 0,
      this.allRadius});

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      shape: RoundedRectangleBorder(
        borderRadius: allRadius != null
            ? BorderRadius.all(Radius.circular(allRadius))
            : BorderRadius.only(
                topLeft: Radius.circular(topLeftRadius),
                topRight: Radius.circular(topRightRadius),
                bottomLeft: Radius.circular(bottomLeftRadius),
                bottomRight: Radius.circular(bottomRightRadius)),
      ),
      color: this.backgroundColor,
      onPressed: onPressed ?? () {},
      child: Text(
        title,
        style: this.textStyle,
      ),
    );
  }
}
