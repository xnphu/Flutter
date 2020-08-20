import 'package:flutter/material.dart';

class RoundedContainer extends StatelessWidget {
  final double height;
  final double width;
  final double allRadius;
  final double bottomLeftRadius;
  final double bottomRightRadius;
  final double topLeftRadius;
  final double topRightRadius;
  final Widget child;
  final Color backgroundColor;
  final BorderSide borderSide;
  final List<BoxShadow> shadows;
  final Gradient gradient;
  final EdgeInsetsGeometry padding;

  RoundedContainer({
    @required this.child,
    this.height,
    this.width,
    this.bottomLeftRadius = 0,
    this.bottomRightRadius = 0,
    this.topLeftRadius = 0,
    this.topRightRadius = 0,
    this.backgroundColor,
    this.borderSide,
    this.shadows,
    this.allRadius,
    this.gradient,
    this.padding: EdgeInsets.zero,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: this.padding,
      color: Colors.transparent,
      child: Container(
        height: this.height,
        width: this.width,
        decoration: BoxDecoration(
          boxShadow: this.shadows,
          color: this.backgroundColor,
          gradient: gradient,
          border:
              (borderSide != null) ? Border.fromBorderSide(borderSide) : null,
          borderRadius: BorderRadius.only(
              bottomLeft:
                  Radius.circular(this.allRadius ?? this.bottomLeftRadius),
              topLeft: Radius.circular(this.allRadius ?? this.topLeftRadius),
              bottomRight:
                  Radius.circular(this.allRadius ?? this.bottomRightRadius),
              topRight: Radius.circular(this.allRadius ?? this.topRightRadius)),
        ),
        child: this.child,
      ),
    );
  }
}
