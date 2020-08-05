import 'package:flutter/material.dart';

textField({String title, TextEditingController controller, Function onChange, Function onSubmit}) {
  return Padding(
    padding: new EdgeInsets.all(8),
    child: TextField(
      controller: controller,
      onChanged: onChange,
      onSubmitted: onSubmit,
      decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          labelText: '$title'),
    ),
  );
}
