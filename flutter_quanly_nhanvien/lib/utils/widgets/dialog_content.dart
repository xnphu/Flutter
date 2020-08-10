import 'package:flutter/material.dart';

dialogContent({Function onTap, Icon icon, String title}) {
  return Container(
    child: Column(
      children: <Widget>[
        InkWell(
          highlightColor: Colors.white,
          radius: 0,
          onTap: () {
            if (onTap != null) onTap();
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: <Widget>[
                icon,
                Text(' $title'),
              ],
            ),
          ),
        ),
        Divider(
          height: 1,
          color: Colors.black,
        )
      ],
    ),
  );
}
