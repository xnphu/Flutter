abstract class BaseState {}

class IdlState extends BaseState {}

class ErrorState extends BaseState {
  String messageError;
  String code;
  ErrorState({this.messageError, this.code});
}

class ValidatedState extends BaseState {}

class LoadingState extends BaseState {}

class FinishState extends BaseState {}
