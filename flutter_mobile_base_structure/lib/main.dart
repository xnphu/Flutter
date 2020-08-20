import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_mobile_base_structure/presentation/app/application_bloc.dart';
import 'package:flutter_mobile_base_structure/presentation/app/application_event.dart';
import 'package:flutter_mobile_base_structure/presentation/app/application_state.dart';
import 'package:flutter_mobile_base_structure/presentation/base/base_state.dart';
import 'package:flutter_mobile_base_structure/presentation/resources/localization/app_localization.dart';
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
  await initInjector();
  _appBloc = ApplicationBloc(repository: injector<AuthenticationRepository>());
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
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        // primarySwatch: Colors.deepOrange,
      ),
      home: BlocBuilder<ApplicationBloc, BaseState>(builder: (context, state) {
        if (state is AppLaunchReadyState) {
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
