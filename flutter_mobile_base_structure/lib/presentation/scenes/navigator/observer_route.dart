import 'package:flutter/material.dart';

class ObserverRoute<T> extends MaterialPageRoute<T> {
  ObserverRoute(Widget widget, {RouteSettings settings})
      : super(
            builder: (_) => RouteAwareWidget(child: widget),
            settings: settings);
}

final RouteObserver<PageRoute> routeObserver = RouteObserver<PageRoute>();

class RouteAwareWidget extends StatefulWidget {
  final Widget child;

  RouteAwareWidget({this.child});

  State<RouteAwareWidget> createState() => RouteAwareWidgetState(child: child);
}

class RouteAwareWidgetState extends State<RouteAwareWidget> with RouteAware {
  final Widget child;

  RouteAwareWidgetState({this.child});

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context));
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }

  @override
  void didPush() {
    // Route was pushed onto navigator and is now topmost route.
    //print('RouteAwareWidgetState didPush');
  }

  @override
  void didPopNext() {
    // Covering route was popped off the navigator.
    // print('RouteAwareWidgetState didPopNext');
  }

  @override
  void didPop() {
    print('RouteAwareWidgetState didPop');
    // BlocProvider.of<ApplicationBloc>(context)
    //     .getPageNavigator(context)
    //     .popStackOfState();
  }

  @override
  Widget build(BuildContext context) => Container(child: child);
}
