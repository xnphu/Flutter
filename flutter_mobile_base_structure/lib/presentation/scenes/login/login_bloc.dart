import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_mobile_base_structure/domain/repository/authen_repository.dart';
import 'package:flutter_mobile_base_structure/domain/usecases/authentication_usecases.dart';
import 'package:flutter_mobile_base_structure/presentation/base/base_bloc.dart';
import 'package:rxdart/rxdart.dart';
import 'login_event.dart';
import 'login_state.dart';

class LoginBloc extends BaseBloc<BaseEvent, BaseState> with Validators {
  String token;
  AuthenticationUseCases authenUseCases;
  AuthenticationRepository authenticationRepository;

  final _fullName = PublishSubject<String>();

  Stream<String> get fullNameStream => _fullName.stream;

//  final _username = ReplaySubject<String>();
  final _email = ReplaySubject<String>();
  final _password = ReplaySubject<String>();

// retrieve data from stream
//  Stream<String> get usernameStream =>
//      _username.stream.transform(validateUsername);

  Stream<String> get emailStream => _email.stream;

  Stream<String> get passwordStream =>
      _password.stream.transform(validatePassword);

  Stream<bool> get submitValid => Rx.combineLatest2<String, String, bool>(
      emailStream,
      passwordStream,
      (emailValid, passwordValid) =>
          emailValid.isNotEmpty && passwordValid.isNotEmpty);

  // add data to stream
//  Function(String) get changeUsername => _username.sink.add;

  Function(String) get changeEmail => _email.sink.add;

  Function(String) get changePassword => _password.sink.add;

  //constructor
//  LoginBloc(this.authenUseCases) : assert(authenUseCases != null);
  LoginBloc(this.authenticationRepository);

//  Stream<BaseState> _login(String username, String password) async* {
//    final eitherFailureOrSuccess =
//        await authenUseCases.login(username, password);
//    yield* eitherFailureOrSuccess.fold((failure) async* {
//      yield LoginFailureState();
//    }, (token) async* {
//      yield LoginSuccessState();
//    });
//  }

  Stream<BaseState> _login(String email, String password) async* {
    String token =
        await authenticationRepository.login(email: email, password: password);
    if (token.isNotEmpty) {
      yield LoginSuccessState();
    } else
      yield LoginFailureState();
  }

  @override
  BaseState get initialState => IdlState();

  @override
  Stream<BaseState> mapEventToState(BaseEvent event) async* {
    if (event is PageBuildEvent) {
      // await _fetchSystemConfig();
    }

    if (event is OnRequestLogInEvent) {
//      final username = _username.values.last;
      final email = _email.values.last;
      final password = _password.values.last;
      yield* _login(email, password);
      String tokenTemp = await authenticationRepository.getCachedToken();
      token = tokenTemp;
    }
  }

  @override
  dispose() {
//    _username.close();
    _email.close();
    _password.close();
    _fullName.close();
  }
}
