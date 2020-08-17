import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_quanly_nhanvien/screens/login/login_event.dart';
import 'package:flutter_quanly_nhanvien/screens/login/login_state.dart';
import 'package:rxdart/rxdart.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final _username = BehaviorSubject<String>();
  final _password = BehaviorSubject<String>();

  disPose() {
    _username.close();
    _password.close();
  }

  Stream<String> get usernameStream => _username.stream;

  Stream<String> get passwordStream => _password.stream;

  Function(String) get changeUsername => _username.sink.add;

  Function(String) get changePassword => _password.sink.add;

  Stream<bool> get validInput => Rx.combineLatest2(
      usernameStream,
      passwordStream,
      (a, b) => a.toString().trim().isNotEmpty && b.toString().trim().isNotEmpty);

  LoginBloc() : super(LoginInitialState());

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    // TODO: implement mapEventToState
    if (event is LoginPressEvent) {
      yield LoginLoadInProgressState();
      await Future.delayed(Duration(seconds: 2));
      yield LoginLoadSuccessState();
    }
  }
}
