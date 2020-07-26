import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trip_challenger/utils/support_device.dart';

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
                          onTap: () {
                            setState(() {
                              isOpen = !isOpen;
                            });
                          },
                          child: Container(
                            width: mWidth(context: context, width: 50),
                            height: mHeight(context: context, height: 30),
                            decoration: BoxDecoration(
                              color: Colors.orange,
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
                                SizedBox(width: mWidth(context: context, width: 5)),
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
//                Container(
//
//                  child: languageMenu(isOpen),
//                ),
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
                Stack(
//                  fit: StackFit.expand,
                  alignment: Alignment.center,
                  overflow: Overflow.clip,
                  children: <Widget>[
                    Image(
                      image: AssetImage(
                          'assets/images/input-field-background.png'),
                      fit: BoxFit.cover,
                    ),
                    Image(
                      color: Colors.grey,
                      image: AssetImage('assets/images/flash.png'),
                      fit: BoxFit.cover,
                    ),
                    Column(
                      children: <Widget>[
                        _textField('Email address', false, email,
                            Icon(Icons.mail_outline)),
                        _textField('Password', true, password,
                            Icon(Icons.lock_outline)),
                      ],
                    ),
                  ],
                ),
                button('LOGIN'),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Text(
                    'Forgot password?',
                    style: TextStyle(
                      decoration: TextDecoration.underline
                    ),
                  ),
                ),
                button('REGISTER'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

_textField(String placeholder, bool isObscureText,
    TextEditingController controller, Icon icon) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
    child: TextField(
      controller: controller,
      obscureText: isObscureText,
      decoration: InputDecoration(
        border: UnderlineInputBorder(),
        labelText: placeholder,
        prefixIcon: icon,
      ),
    ),
  );
}
languageMenu (bool isOpen) {
    if(isOpen == true){
      return Image(
        image: AssetImage(
            'assets/images/language-menu.png'),
        fit: BoxFit.cover,
      );
    }
    else return SizedBox(height: 0,);
}

button(String text) {
  return InkWell(
    onTap: () {},
    child: Container(
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Image(
            image: AssetImage('assets/images/orange-button.png'),
            fit: BoxFit.cover,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Text(
                text,
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Image(
                    image: AssetImage(
                        'assets/images/arrow-grey.png'),
                    fit: BoxFit.cover,
                  ),
                  Image(
                    image: AssetImage(
                        'assets/images/arrow-white.png'),
                    fit: BoxFit.cover,
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    ),
  );
}
