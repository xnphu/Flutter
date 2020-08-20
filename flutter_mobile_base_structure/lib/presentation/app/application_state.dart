import 'package:flutter_mobile_base_structure/presentation/base/base_state.dart';

abstract class ApplicationState extends BaseState {}

class AppLaunchLoadProfileState extends ApplicationState {}

class AppLaunchReadyState extends ApplicationState {
  bool isTokenAlive = false;
  AppLaunchReadyState({this.isTokenAlive});
}

class AppLaunchErrorState extends ApplicationState {
  String message;
  AppLaunchErrorState({this.message}) : assert(message.isNotEmpty);
}

const APP_LAUNCH_ERROR_MESSAGE = "application cannot start";
