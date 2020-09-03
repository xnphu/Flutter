import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_mobile_base_structure/presentation/app/application_bloc.dart';
import 'package:flutter_mobile_base_structure/presentation/app/application_event.dart';
import 'package:flutter_mobile_base_structure/presentation/app/application_state.dart';
import 'package:flutter_mobile_base_structure/presentation/base/base_state.dart';
import 'package:flutter_mobile_base_structure/presentation/resources/localization/app_localization.dart';
import 'package:flutter_mobile_base_structure/presentation/scenes/home/home_page.dart';
import 'package:flutter_mobile_base_structure/presentation/scenes/login/login_page.dart';
import 'package:flutter_mobile_base_structure/presentation/scenes/navigator/observer_route.dart';
import 'domain/repository/authen_repository.dart';
import 'package:flutter_mobile_base_structure/presentation/base/base_bloc.dart';
import 'presentation/scenes/login/index.dart';
import 'presentation/styles/app_colors.dart';
import 'presentation/styles/text_style.dart';
import './app_injector.dart';

ApplicationBloc _appBloc;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initInjector();
  _appBloc = injector<ApplicationBloc>();
  runApp(BlocProvider<ApplicationBloc>(
      create: (BuildContext context) => _appBloc, child: MyApp()));
}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    _appBloc.dispatchEvent(AppLaunched());
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(),
      home: BlocBuilder<ApplicationBloc, BaseState>(builder: (context, state) {
        if (state is AppLaunchReadyState) {
          if (state.isTokenAlive==true) {
            return HomePage(username: 'tp',);
          }
          return LoginPage();
        }
        return _buidLoadingProfileScene();
      }),
      localizationsDelegates: [
        const AppLocalizationsDelegate(),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: AppLocalizations.supportedLanguages(),
      navigatorObservers: [routeObserver],
    );
  }

  _buidLoadingProfileScene() {
    return Scaffold(
      body: Container(
          child: Center(
              child: Text("Đang tải dữ liệu...",
                  style: getTextStyle(
                      fontSize: 22,
                      color: AppColors.white,
                      fontWeight: FontWeight.bold))),
          decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [AppColors.secondaryColor, AppColors.primaryColor],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight),
          )),
    );
  }
}
