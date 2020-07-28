import 'package:flutter/material.dart';

import '../hex_color.dart';
import '../support_device.dart';

button({BuildContext context, String text}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 10),
    child: Container(
      height: mHeight(context: context, height: 48),
      padding: EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Color.fromARGB((0.25 * 255).toInt(), 0, 0, 0),
            offset: Offset(0, 4),
            blurRadius: 4,
          )
        ],
        gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [HexColor('#FFC555'), HexColor('#F49220')]),
        borderRadius: BorderRadius.circular(26),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          SizedBox(
            width: mWidth(context: context, width: 60),
          ),
          Text(
            text,
            style: TextStyle(
              color: Colors.white,
              fontStyle: FontStyle.normal,
              fontSize: 22,
              fontWeight: FontWeight.w500,
            ),
          ),
          Row(
            children: <Widget>[
              Image(
                image: AssetImage('assets/images/arrow-grey.png'),
                fit: BoxFit.cover,
              ),
              Image(
                image: AssetImage('assets/images/arrow-white.png'),
                fit: BoxFit.cover,
              ),
            ],
          ),
        ],
      ),
    ),
  );
}