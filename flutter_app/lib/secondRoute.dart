import 'dart:convert';
import 'package:flutter/material.dart';

class SecondRoute extends StatelessWidget {
  final emailHolder;
  final passwordHolder;
  final List<ImageList> allImage; //them kieu

  SecondRoute({Key key, @required this.emailHolder, this.passwordHolder, this.allImage})
      : super(key: key);

    @override
  Widget build(BuildContext context) {
      print('aaaaaaa : ${allImage[0].title}');
    return Scaffold(
      appBar: AppBar(
        title: Text("Second Route"),
      ),
      body: Column(
        children: <Widget>[
//            RaisedButton(
//              onPressed: () {
//                Navigator.pop(context);
//              },
//              child: Text('Go back!'),
//            ),
          Text('$emailHolder'),
          Text('$passwordHolder'),
          Expanded(
            child: GridView.builder(itemCount: allImage.length, gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2), itemBuilder: (context, index) {
              return Container(
                child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      (Image.network(
                        '${allImage[index].url}', width: 200, height: 150, fit: BoxFit.cover,
                      )),
                      (Text(
                        '${allImage[index].title}', textAlign: TextAlign.center,
                      )),
                    ],
                  ),
                ),
              );
            }),
          )
        ],
      ),
    );
  }
}

class ImageList {
  final int albumId;
  final int id;
  final String title;
  final String url;

  ImageList({this.albumId, this.id, this.title, this.url});

  ImageList.fromJson(Map<String, dynamic> json)
      : albumId= json['albumId'],
        id = json['id'],
        title = json['title'],
        url = json['url'];

  Map<String, dynamic> toJson() =>
      {
        'albumId': albumId,
        'id': id,
        'title': title,
        'url': url,
      };
}