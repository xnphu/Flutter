import 'package:flutter/material.dart';
import 'package:flutter_mobile_base_structure/presentation/styles/app_colors.dart';

class ProgressHud extends StatefulWidget {
  final bool dismissible;
  final Widget child;
  final Stream<bool> stream;
  final bool showInBuild;

  static fromStream({Stream<bool> stream, Widget child, bool showInBuild}) {
    return ProgressHud(stream: stream, child: child, showInBuild: showInBuild);
  }

  ProgressHud(
      {Key key,
      this.dismissible = false,
      this.child,
      this.stream,
      this.showInBuild});

  @override
  State<StatefulWidget> createState() => ProgressHudState();
}

class ProgressHudState extends State<ProgressHud> {
  @override
  Widget build(BuildContext context) {
    if (this.widget.stream != null) {
      return StreamBuilder<bool>(
        stream: widget.stream,
        builder: (context, snapshot) {
          final willShow = snapshot?.data ?? this.widget.showInBuild;
          return _hudContent(willShow);
        },
      );
    } else {
      return _hudContent(true);
    }
  }

  _hudContent(bool willShow) {
    List<Widget> items = [];
    if (this.widget.child != null) {
      items.add(this.widget.child);
    }

    if (willShow) {
      items.add(Center(
          child: CircularProgressIndicator(
              backgroundColor: AppColors.green56,
              valueColor: AlwaysStoppedAnimation<Color>(AppColors.green58))));
      items.add(Opacity(
        opacity: 0.3,
        child:
            ModalBarrier(dismissible: widget.dismissible, color: Colors.white),
      ));
    }
    return Container(child: Stack(fit: StackFit.passthrough, children: items));
  }
}
