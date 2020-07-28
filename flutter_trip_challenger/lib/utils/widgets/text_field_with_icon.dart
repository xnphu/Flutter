import 'package:flutter/material.dart';

textFieldWithIcon(String placeholder, bool isObscureText,
    TextEditingController controller, Icon icon) {
  return TextField(
    controller: controller,
    obscureText: isObscureText,
    decoration: InputDecoration(
      border: UnderlineInputBorder(),
      labelText: placeholder,
      prefixIcon: icon,
    ),
  );
}