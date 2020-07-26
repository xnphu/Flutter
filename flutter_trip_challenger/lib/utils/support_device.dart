import 'package:flutter/cupertino.dart';
const BASE_WIDTH = 375;
const BASE_HEIGHT = 812;
double mWidth({BuildContext context, double width}) {
  return width * MediaQuery.of(context).size.width/BASE_WIDTH;
}

double mHeight({BuildContext context, double height}) {
  return height * MediaQuery.of(context).size.height/BASE_HEIGHT;
}