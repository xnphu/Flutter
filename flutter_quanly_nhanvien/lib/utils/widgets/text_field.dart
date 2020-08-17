import 'package:flutter/material.dart';

textField({String title, TextEditingController controller, Function onChange, bool isEnable, bool isObscureText}) {
  return Padding(
    padding: new EdgeInsets.all(8),
    child: TextField(
      controller: controller,
      onChanged: onChange,
      enabled: isEnable,
      obscureText: isObscureText!=null ? true : false,
      decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          labelText: '$title'),
    ),
  );
}
