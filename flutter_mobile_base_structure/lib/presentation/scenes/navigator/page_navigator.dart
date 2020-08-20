import 'package:flutter/material.dart';
import 'package:flutter_mobile_base_structure/core/utils/stack.dart';
import 'package:flutter_mobile_base_structure/presentation/utils/app_sate.dart';
import 'observer_route.dart';

class PageNavigator {
  final StackData<AppState> _stackOfState = StackData();
  PageNavigator({AppState initTag}) {
    _stackOfState.push(initTag);
  }
  AppState firstState() => _stackOfState.first();
  AppState currentState() => _stackOfState.top();
  AppState previousState() {
    final stackCount = _stackOfState.count();
    if (stackCount >= 2) {
      return _stackOfState.elementAt(stackCount - 2);
    }
    return currentState();
  }

  popStackOfState() {
    _stackOfState.pop();
  }

  replaceTopOfStackBy(AppState newSate) {
    _stackOfState.pop();
    _stackOfState.push(newSate);
  }

  materialPush(
      {@required BuildContext context, @required Widget page, AppState tag}) {
    _stackOfState.push(tag);
    RouteSettings settings = RouteSettings(name: tag.toString());
    final route = ObserverRoute(page, settings: settings);
    Navigator.push(context, route);
  }

  _materialPushAndRemoveUntil(
      {@required BuildContext context,
      @required Widget page,
      @required RoutePredicate predicate,
      AppState tag}) {
    RouteSettings settings = RouteSettings(name: tag.toString());
    final route = ObserverRoute(page, settings: settings);
    Navigator.pushAndRemoveUntil(context, route, predicate);
  }

  materialPushAndRemoveUntilTag(
      {@required AppState stopTag,
      @required BuildContext context,
      @required Widget page,
      AppState newTag}) {
    _stackOfState.popUntil(stop: stopTag);
    _stackOfState.push(newTag);
    _materialPushAndRemoveUntil(
        context: context,
        page: page,
        tag: newTag,
        predicate: (Route<dynamic> route) {
          print(
              ' route.settings.name == ${route.settings.name}  stopTag.toString() = ${stopTag.toString()}');
          final match = route.settings.name == stopTag.toString();

          return match;
        });
  }

  materialPushAndRemoveAll(
      {@required BuildContext context, @required Widget page, AppState tag}) {
    _stackOfState.popAll();
    _stackOfState.push(tag);
    _materialPushAndRemoveUntil(
        context: context,
        page: page,
        tag: tag,
        predicate: (Route<dynamic> route) {
          return false;
        });
  }

  popBack({@required BuildContext context}) {
    Navigator.of(context).pop();
  }

  popToRoot({@required BuildContext context}) {
    Navigator.of(context).popUntil((Route<dynamic> route) {
      return route.isFirst;
    });
  }

  popUntilTag({
    @required AppState stopTag,
    @required BuildContext context,
  }) {
    // _stackOfState.popUntil(stop: stopTag);
    Navigator.of(context).popUntil((Route<dynamic> route) {
      final match = route.settings.name == stopTag.toString();
      return match;
    });
  }
}
