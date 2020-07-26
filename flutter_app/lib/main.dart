import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'secondRoute.dart';
import 'package:dio/dio.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.green,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool test = false;
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
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Center(
                    child:
                        Image(image: AssetImage('assets/images/Flutter.png'))),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Welcome Back!',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                      ),
                    ),
                    Text(
                      'sign in to continue',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                _textField('Email address', false, email),
                _textField('Password', true, password),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Text(
                        'Forgot password?',
                        style: TextStyle(color: Colors.blue),
                        textAlign: TextAlign.end,
                      ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    FlatButton(
                        onPressed: () {
                          setState(() {
                            test = !test;
                          });
                        },
                        color: test == false ? Colors.blue : Colors.red,
                        textColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Text('Sign in'),
                        )),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text("Don't have an account"),
                      GestureDetector(
                        onTap: () async {
                          try {
                            Response response = await Dio().get("https://jsonplaceholder.typicode.com/albums/1/photos");
                          var allImage =  (response.data as List).map((e) => ImageList.fromJson(e)).toList();
                            print('aaaaa ${allImage[0].title}');
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SecondRoute(
                                      emailHolder: email.text,
                                      passwordHolder: password.text,
                                      allImage: allImage
                                    )),
                          );
                          } catch (e) {
                            print(e);
                          }
                        },
                        child: Text(
                          ' Register ',
                          style: TextStyle(color: Colors.blue),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
//      floatingActionButton: FloatingActionButton(
//        onPressed: _incrementCounter,
//        tooltip: 'Increment',
//        child: Icon(Icons.add),
//      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

_textField(String title, bool isObscureText, TextEditingController controller) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 15),
    child: TextField(
      controller: controller,
      obscureText: isObscureText,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        labelText: title,
      ),
    ),
  );
}
