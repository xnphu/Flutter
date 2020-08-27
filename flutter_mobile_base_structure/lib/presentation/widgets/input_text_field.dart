import 'package:flutter/material.dart';
import 'package:flutter_mobile_base_structure/presentation/styles/styles.dart';

inputTextField(
    {bool readOnly = false,
      bool isSecurity = false,
      double height = 40,
      TextInputType keyboardType = TextInputType.text,
      String placeHolder = "",
      FocusNode focusNode,
      TextEditingController controller,
      TextStyle hintStyle,
      TextStyle style,
      Function(String) onChanged,
      InputBorder enabledBorder,
      InputBorder focusedBorder,
      bool autofocus: false,
      int maxLines = 1}) {
  return Container(
    // height: height,
    // color: Colors.green,
    child: Center(
      child: TextField(
        autofocus: autofocus,
        readOnly: readOnly,
        decoration: InputDecoration(
            hintStyle: hintStyle ??
                getHintTextStyle(hintColor: AppColors.white50, fontSize: 19),
            hintText: placeHolder,
            enabledBorder:
            enabledBorder ?? underlineBorder(color: Colors.transparent),
            focusedBorder:
            focusedBorder ?? underlineBorder(color: Colors.transparent)),
        style: style ?? getTextStyle(color: Colors.black, fontSize: 19),
        keyboardType: keyboardType,
        obscureText: isSecurity,
        focusNode: focusNode,
        controller: controller,
        onChanged: onChanged,
      ),
    ),
  );
}