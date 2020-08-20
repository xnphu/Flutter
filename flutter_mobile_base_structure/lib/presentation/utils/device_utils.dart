import 'package:flutter/material.dart';

bool isSceneLargerThanIphone5({@required BuildContext context}) {
  return MediaQuery.of(context).size.width > 320;
}
