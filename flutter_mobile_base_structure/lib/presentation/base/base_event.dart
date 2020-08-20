import 'package:flutter/material.dart';

abstract class BaseEvent {}

class PageInitStateEvent extends BaseEvent {
  BuildContext context;
  PageInitStateEvent({this.context});
}

class PageDidChangeDependenciesEvent extends BaseEvent {
  BuildContext context;
  PageDidChangeDependenciesEvent({this.context}) : assert(context != null);
}

class PageBuildEvent extends BaseEvent {
  BuildContext context;
  PageBuildEvent({this.context}) : assert(context != null);
}

class FinishEvent extends BaseEvent {}

class OnBackPressedEvent extends BaseEvent {}

class OnResultEvent extends BaseEvent {
  dynamic result;
  OnResultEvent({this.result});
}

class ApplicationInactiveEvent extends BaseEvent {}

class ApplicationResumeEvent extends BaseEvent {}
