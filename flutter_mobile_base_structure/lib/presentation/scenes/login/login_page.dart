import 'package:flutter/material.dart';
import 'package:flutter_mobile_base_structure/presentation/base/base_bloc.dart';
import 'package:flutter_mobile_base_structure/presentation/base/base_page.dart';
import 'package:flutter_mobile_base_structure/presentation/scenes/home/index.dart';
import 'package:flutter_mobile_base_structure/presentation/widgets/index.dart';

import 'login_bloc.dart';
import 'login_event.dart';
import 'login_router.dart';

class LoginPage extends BasePage {
  @override
  State<StatefulWidget> createState() => LoginPageState();
}

class LoginPageState extends BasePageState<LoginBloc, LoginPage, LoginRouter>
    with LoginPageMixin {
  LoginBloc _bloc;
  final FocusNode _nodeUsername = FocusNode();
  final FocusNode _nodePassword = FocusNode();
  final ScrollController _controller = ScrollController();

  @override
  Widget buildBody(BuildContext context, BaseBloc bloc) {
    return _buildRegisterPage(context, bloc);
  }

  @override
  void initState() {
    super.initState();
    _nodeUsername.addListener(() {
      if (_nodeUsername.hasFocus) {
        _scrollUp();
      }
    });
    _nodePassword.addListener(() {
      if (_nodePassword.hasFocus) {
        _scrollUp();
      }
    });
  }

  _scrollUp() {
    _controller.animateTo(50,
        duration: Duration(milliseconds: 200), curve: Curves.easeIn);
  }

  _buildRegisterPage(BuildContext context, LoginBloc bloc) {
    _bloc = bloc;
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
            colors: [AppColors.secondaryColor, AppColors.primaryColor],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight),
      ),
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
            controller: _controller,
            physics: NeverScrollableScrollPhysics(),
            child: SafeArea(
              child: Column(
                children: <Widget>[
                  _buildLogo(),
                  buildInputRow(
                      onChanged: _bloc.changeUsername,
                      icon: AppImages.iconUsername,
                      tintText: AppLocalizations.of(context).inputUsername,
                      node: _nodeUsername),
                  buildInputRow(
                      isSecurity: true,
                      onChanged: _bloc.changePassword,
                      icon: AppImages.iconUnlock,
                      tintText: AppLocalizations.of(context).inputPassword,
                      node: _nodePassword),
                  _buildLoginButton(context),
                  Container(height: 50)
                ],
              ),
            )),
      ),
    );
  }

  _buildLogo() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 30),
      child: Image(
          color: Colors.white,
          image: AppImages.iconLogo,
          width: 200,
          height: 130,
          fit: BoxFit.contain),
    );
  }

  _buildLoginButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 30, left: 20, right: 20, bottom: 50),
      child: Container(
          width: double.infinity,
          height: 50,
          child: StreamBuilder<bool>(
              stream: _bloc.submitValid,
              initialData: false,
              builder: (_, data) {
                final isValid = data.data ?? false;
                final titleStyle = getTextStyle(
                    color: isValid
                        ? AppColors.secondaryColor
                        : AppColors.lightBlack50,
                    fontSize: 17,
                    fontFamily: AppFonts.sfProText,
                    fontWeight: FontWeight.w600);

                return isValid
                    ? RoundedTextButton(
                        allRadius: 25,
                        backgroundColor: AppColors.white,
                        onPressed: () {
                          hideKeyboard(context);
//                          _bloc.add(OnRequestLogInEvent());
                          navigator.materialPush(
                              context: context, page: HomePage(username: 'tp',));
                        },
                        title: AppLocalizations.of(context).loginButton,
                        textStyle: titleStyle,
                      )
                    : RoundedContainer(
                        allRadius: 25,
                        backgroundColor: AppColors.white,
                        child: Center(
                            child: Text(
                          AppLocalizations.of(context).loginButton,
                          style: titleStyle,
                        )));
              })),
    );
  }
}

class LoginPageMixin {
  buildInputRow(
      {bool isSecurity = false,
      TextInputType type = TextInputType.text,
      AssetImage icon,
      String tintText,
      FocusNode node,
      Function(String) onChanged}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: RoundedContainer(
          padding: const EdgeInsets.all(10.0),
          allRadius: 27,
          borderSide: BorderSide(
            color: Colors.white,
          ),
          height: 55,
          child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image(
                      color: Colors.white,
                      image: icon,
                      width: 20,
                      height: 20,
                      fit: BoxFit.contain),
                ),
                Expanded(
                    child: buildInputText(
                        isSecurity: isSecurity,
                        keyboardType: type,
                        onChanged: onChanged,
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        focusNode: node,
                        placeHolder: tintText,
                        style: getTextStyle(
                            fontSize: 20, color: AppColors.white))),
              ])),
    );
  }

  buildInputText(
      {bool readOnly = false,
      bool isSecurity = false,
      double height = 40,
      TextInputType keyboardType = TextInputType.text,
      String placeHolder = "",
      FocusNode focusNode,
      TextEditingController controller,
      TextStyle hintStyle,
      TextStyle style,
      Function(String) onChanged,
      InputBorder enabledBorder,
      InputBorder focusedBorder,
      bool autofocus: false,
      int maxLines = 1}) {
    return Container(
      // height: height,
      // color: Colors.green,
      child: Center(
        child: TextField(
          autofocus: autofocus,
          readOnly: readOnly,
          decoration: InputDecoration(
              hintStyle: hintStyle ??
                  getHintTextStyle(hintColor: AppColors.white50, fontSize: 19),
              hintText: placeHolder,
              enabledBorder:
                  enabledBorder ?? underlineBorder(color: Colors.transparent),
              focusedBorder:
                  focusedBorder ?? underlineBorder(color: Colors.transparent)),
          style: style ?? getTextStyle(color: Colors.black, fontSize: 19),
          keyboardType: keyboardType,
          obscureText: isSecurity,
          focusNode: focusNode,
          controller: controller,
          onChanged: onChanged,
        ),
      ),
    );
  }
}
