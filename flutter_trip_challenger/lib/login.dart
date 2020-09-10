import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trip_challenger/custom_paint_page.dart';
import 'package:flutter_trip_challenger/home.dart';
import 'package:flutter_trip_challenger/register.dart';
import 'package:flutter_trip_challenger/utils/hex_color.dart';
import 'package:flutter_trip_challenger/utils/support_device.dart';
import 'package:flutter_trip_challenger/utils/widgets/orange_button.dart';
import 'package:flutter_trip_challenger/utils/widgets/text_field_with_icon.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isOpen = false;
  final email = TextEditingController();
  final password = TextEditingController();
  final String emailHolder = '';
  final String passwordHolder = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 15),
            height: MediaQuery.of(context).size.height,
            child: Column(
              children: <Widget>[
                SizedBox(height: mHeight(context: context, height: 15)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        InkWell(
                          highlightColor: Colors.white,
                          radius: 0,
                          onTap: () {
                            setState(() {
                              isOpen = !isOpen;
                            });
                          },
                          child: Container(
                            width: mWidth(context: context, width: 50),
                            height: mHeight(context: context, height: 30),
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                  begin: Alignment.centerLeft,
                                  end: Alignment.centerRight,
                                  colors: [
                                    HexColor('#FFC555'),
                                    HexColor('#F49220')
                                  ]),
                              borderRadius: BorderRadius.circular(
                                  mHeight(context: context, height: 15)),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Image(
                                  color: Colors.white,
                                  image: AssetImage('assets/images/round.png'),
                                  fit: BoxFit.cover,
                                ),
                                SizedBox(
                                    width: mWidth(context: context, width: 5)),
                                Text(
                                  'EN',
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        languageMenu(isOpen),
                      ],
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'LOGIN',
                      style: TextStyle(
                        color: Colors.orange,
                        fontSize: 30,
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 0, vertical: 10),
                  child: Container(
                    width: mWidth(context: context, width: 335),
                    height: mHeight(context: context, height: 310),
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                            color:
                                Color.fromARGB((0.25 * 255).toInt(), 0, 0, 0),
                            offset: Offset(0, 4),
                            blurRadius: 4)
                      ],
                      gradient: LinearGradient(
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                          colors: [HexColor('#FFE2AA'), HexColor('#FDD9A1')]),
                      borderRadius: BorderRadius.circular(26),
                    ),
                    child: Stack(
                      alignment: Alignment.center,
                      children: <Widget>[
                        Positioned(
                          bottom: 5,
                          child: Image(
                            image: AssetImage('assets/images/flash-grey.png'),
                            fit: BoxFit.cover,
                          ),
                        ),
                        Container(
                          width: mWidth(context: context, width: 330),
                          padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              textFieldWithIcon('Email address', false, email,
                                  Icon(Icons.mail_outline)),
                              textFieldWithIcon('Password', true, password,
                                  Icon(Icons.lock_outline)),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                InkWell(
                  highlightColor: Colors.white,
                  radius: 0,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => HomePage()),
                    );
                  },
                  child: button(context: context, text: 'Login'),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Text(
                    'Forgot password?',
                    style: TextStyle(decoration: TextDecoration.underline),
                  ),
                ),
                InkWell(
                  highlightColor: Colors.white,
                  radius: 0,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => RegisterPage()),
                    );
                  },
                  child: button(context: context, text: 'Register'),
                ),
                InkWell(
                  highlightColor: Colors.white,
                  radius: 0,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => CustomPaintPage()),
                    );
                  },
                  child: button(context: context, text: 'Vẽ hình'),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  languageMenu(bool isOpen) {
    if (isOpen == true) {
      return Image(
        image: AssetImage('assets/images/language-menu.png'),
        fit: BoxFit.cover,
      );
    } else
      return SizedBox(
        height: 0,
      );
  }
}
