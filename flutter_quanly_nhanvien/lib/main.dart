import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_quanly_nhanvien/screens/login/index.dart';
import 'package:flutter_quanly_nhanvien/screens/login/login_bloc.dart';
import 'package:flutter_quanly_nhanvien/screens/room/room_bloc.dart';

void main() {
  runApp(MultiBlocProvider(providers: [
    BlocProvider<LoginBloc>(
      create: (context) => LoginBloc(),
    ),
    BlocProvider<RoomBloc>(
      create: (context) => RoomBloc(),
    )
  ], child: MyApp()));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
//      home: MyHomePage(title: 'Quan ly nhan vien'),
      home: LoginScreen(),
    );
  }
}
