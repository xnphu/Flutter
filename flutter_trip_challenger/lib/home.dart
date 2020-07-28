import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_trip_challenger/utils/hex_color.dart';
import 'package:flutter_trip_challenger/utils/support_device.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
//  var scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
//      key: scaffoldKey,
//      appBar: AppBar(
//      ),
      drawer: Drawer(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [ HexColor('#FFFFFF'), HexColor('#FFF3E2')]),
            borderRadius: BorderRadius.circular(25),
          ),
          child: ListView(
            children: <Widget>[
              DrawerHeader(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        IconButton(
                            icon: Image.asset('assets/images/edit-icon.png'),
                            onPressed: null),
                      ],
                    ),
                    Column(
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Container(
                              color: Colors.orange,
                              width: 5,
                              height: 19,
                            ),
                            SizedBox(width: 5),
                            Text(
                              'John Ferguson',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 23,
                                fontStyle: FontStyle.normal,
                              ),
                            )
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                IconButton(
                                    icon: Image.asset(
                                        'assets/images/male-gender.png'),
                                    onPressed: null),
                                Text('24',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.normal,
                                      fontSize: 12,
                                      fontStyle: FontStyle.normal,
                                    )),
                              ],
                            ),
                            SizedBox(width: 50),
                            Text('69kg',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.normal,
                                  fontSize: 12,
                                  fontStyle: FontStyle.normal,
                                )),
                            SizedBox(width: 50),
                            Text('175cm',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.normal,
                                  fontSize: 12,
                                  fontStyle: FontStyle.normal,
                                )),
                          ],
                        ),
                      ],
                    )
                  ],
                ),
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/images/avatar-user.png'),
                        fit: BoxFit.cover),
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(25),
                        bottomRight: Radius.circular(25))),
              ),
              rowDrawer(imagePath: 'assets/images/training-icon.png', title: 'Training'),
              rowDrawer(imagePath: 'assets/images/challenge-icon.png', title: 'Challenge'),
              rowDrawer(imagePath: 'assets/images/report-icon.png', title: 'Report'),
              rowDrawer(imagePath: 'assets/images/logout-icon.png', title: 'Log out'),
              SizedBox(
                height: mHeight(context: context, height: 87),
              ),
              rowDrawer(imagePath: 'assets/images/training-icon.png', title: 'Training'),
            ],
          ),
        ),
      ),
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            pinned: true,
            backgroundColor: Colors.transparent,
            expandedHeight: 250.0,
            flexibleSpace: Container(
              width: double.infinity,
              child: Image(
                image: AssetImage('assets/images/header-image.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
//          SliverList(
//            delegate: SliverChildBuilderDelegate(
//                  (BuildContext context, int index) {
//                return Container(
//                  alignment: Alignment.center,
//                  color: HexColor('#FFF3E2'),
//                );
//              },
//            ),
//          )
//          Container(
//            width: double.infinity,
//            height: MediaQuery.of(context).size.height,
//            decoration: BoxDecoration(
//              color: HexColor('#FFF3E2')
//            ),
//          )
        ],
      ),
    );
  }

  rowDrawer({ String imagePath, String title, Function () onPressed }) {
    return (
        Row(
          children: <Widget>[
            IconButton(
                icon: Image.asset(imagePath),
                onPressed: null),
            Text(
              title,
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w500,
                fontSize: 12,
                fontStyle: FontStyle.normal,
              ),
            )
          ],
        )
    );
  }
}
