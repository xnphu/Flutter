import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobile_base_structure/presentation/styles/styles.dart';

export 'package:flutter_mobile_base_structure/presentation/resources/icons/app_images.dart';
export 'package:flutter_mobile_base_structure/presentation/styles/text_style.dart';
export 'package:flutter_mobile_base_structure/presentation/styles/app_colors.dart';
export 'package:flutter_mobile_base_structure/presentation/resources/localization/app_localization.dart';
export 'package:flutter/material.dart';
export 'package:flutter_mobile_base_structure/presentation/styles/styles.dart';
export 'package:keyboard_actions/keyboard_actions.dart';
export 'package:flutter_mobile_base_structure/presentation/utils/device_utils.dart';

mixin BasePageMixin {
  Future<void> showSnackBarMessage(String msg, BuildContext context) async {
    final snackBar = SnackBar(
      backgroundColor: AppColors.primaryColor,
      content: Container(
        height: 40,
        color: AppColors.primaryColor,
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text(msg,
              style:
                  getTextStyle(color: Colors.red, fontWeight: FontWeight.w500)),
        ),
      ),
    );
    Scaffold.of(context).showSnackBar(snackBar);
  }

  hideKeyboard(context) {
    FocusScope.of(context).requestFocus(new FocusNode());
  }

  Future<bool> showAlert({
    @required BuildContext context,
    String title,
    @required String message,
    String okActionTitle,
    String cancelTitle,
  }) async {
    List<Widget> actions = [];
    if (cancelTitle?.isNotEmpty ?? false) {
      actions.add(FlatButton(
        child: new Text(cancelTitle,
            style:
                getTextStyle(color: Colors.black, fontWeight: FontWeight.w600)),
        onPressed: () {
          return Navigator.of(context).pop(false);
        },
      ));
    }

    if (okActionTitle?.isNotEmpty ?? false) {
      actions.add(FlatButton(
        child: new Text(okActionTitle ?? "OK",
            style:
                getTextStyle(color: Colors.black, fontWeight: FontWeight.w600)),
        onPressed: () {
          return Navigator.of(context).pop(true);
        },
      ));
    }
    return showGeneralDialog<bool>(
        barrierColor: Colors.black.withOpacity(0.5),
        transitionBuilder: (context, a1, a2, widget) {
          return Transform.scale(
            scale: a1.value,
            child: Opacity(
              opacity: a1.value,
              child: CupertinoAlertDialog(
                  title: new Text(title ?? ''),
                  content: new Text(message),
                  actions: actions),
            ),
          );
        },
        transitionDuration: Duration(milliseconds: 200),
        barrierDismissible: false,
        barrierLabel: 'hheheh',
        context: context,
        pageBuilder: (context, animation1, animation2) {});
  }

  buildSeparator(
      {EdgeInsets padding = const EdgeInsets.only(left: 20, right: 20),
      double height = 0.5,
      Color color: AppColors.lightGrey}) {
    return Padding(
      padding: padding,
      child: Container(
        height: height,
        color: color,
      ),
    );
  }

  buildLoading() {
    return Container(
      child: Center(child: CircularProgressIndicator()),
    );
  }

  buildEmptyMessage() {
    return LayoutBuilder(builder: (context, constraints) {
      return SingleChildScrollView(
        child: Container(
          height: constraints.maxHeight + 2,
          child: Center(
              child: Text('Danh sách trống',
                  style: getTextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.w500))),
        ),
      );
    });
  }
}
