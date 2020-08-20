import 'package:flutter/material.dart';
import 'package:flutter_mobile_base_structure/domain/repository/authen_repository.dart';
import 'package:flutter_mobile_base_structure/presentation/base/base_bloc.dart';
import 'package:flutter_mobile_base_structure/presentation/base/base_event.dart';
import 'application_event.dart';
import 'application_state.dart';

class ApplicationBloc extends BaseBloc<ApplicationEvent, ApplicationState> {
  AuthenticationRepository repository;
  PublishSubject<BaseEvent> _appEventManager = PublishSubject<BaseEvent>();

  Stream<BaseEvent> get appEventStream => _appEventManager.stream;

  ApplicationBloc({@required this.repository}) : assert(repository != null);

  @override
  ApplicationState get initialState => AppLaunchLoadProfileState();

  @override
  Stream<ApplicationState> mapEventToState(BaseEvent event) async* {
    if (event is AppLaunched) {
      await Future.delayed(Duration(seconds: 2));
      yield AppLaunchReadyState(isTokenAlive: true);
    } else {
      yield AppLaunchLoadProfileState();
    }
    _appEventManager.add(event);
  }

  @override
  void dispose() {
    _appEventManager.close();
  }
}
