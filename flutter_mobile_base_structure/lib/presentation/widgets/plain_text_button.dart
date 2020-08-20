import 'package:flutter/material.dart';
import 'package:flutter_mobile_base_structure/presentation/styles/text_style.dart';

class PlainTextButton extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;
  final TextStyle textStyle;
  final Color backgroundColor;
  final double width;
  final double height;

  PlainTextButton(
      {@required this.title,
      @required this.textStyle,
      @required this.onPressed,
      this.backgroundColor,
      this.width,
      this.height});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      child: FlatButton(
        padding: EdgeInsets.zero,
        onPressed: () {
          if (this.onPressed != null) this.onPressed();
        },
        child: Text(
          this.title,
          style: textStyle ??
              getTextStyle(
                  color: Colors.black,
                  fontSize: 40,
                  fontWeight: FontWeight.w300),
        ),
      ),
    );
  }
}
