import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_quanly_nhanvien/screens/home/index.dart';
import 'package:flutter_quanly_nhanvien/screens/login/login_bloc.dart';
import 'package:flutter_quanly_nhanvien/screens/login/login_event.dart';
import 'package:flutter_quanly_nhanvien/screens/login/login_state.dart';
import 'package:flutter_quanly_nhanvien/utils/widgets/text_field.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => new _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  LoginBloc _loginBloc;
  final TextEditingController usernameController = new TextEditingController();
  final TextEditingController passwordController = new TextEditingController();
  bool isButtonEnabled = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loginBloc = BlocProvider.of<LoginBloc>(context);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _loginBloc.disPose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
            },
            child: BlocBuilder(
              bloc: _loginBloc,
              builder: (context, state) {
                var isLoading = state is LoginLoadInProgressState;
                if (state is LoginLoadInProgressState) {
                  isLoading = true;
                }
                if (state is LoginLoadFailureState) {
                  return Center(
                    child: Text('Lay thong tin that bai'),
                  );
                }
                if (state is LoginLoadSuccessState) {}
                var content = Stack(
                  children: <Widget>[
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              'Dang nhap',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                        textField(
                          title: 'Tai khoan',
                          controller: usernameController,
                          onChange: _loginBloc.changeUsername,
                        ),
                        textField(
                          title: 'Mat Khau',
                          controller: passwordController,
                          isObscureText: true,
                          onChange: _loginBloc.changePassword,
                        ),
                        StreamBuilder(
                          initialData: false,
                          stream: _loginBloc.validInput,
                          builder: (_, data) {
                            var isShowLoginButton = data.data ?? false;
                            return isShowLoginButton
                                ? RaisedButton(
                                    color: Colors.lightBlue,
                                    onPressed: () async {
                                      _loginBloc.add(LoginPressEvent());
                                      await Future.delayed(
                                          Duration(seconds: 2));
                                      String _username = usernameController.text;
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => MyHomePage(
                                                    username:
                                                        _username,
                                                  )));

                                      usernameController.clear();
                                      passwordController.clear();
                                      _loginBloc.changeUsername('');
                                      _loginBloc.changePassword('');
                                      FocusScope.of(context).unfocus();
                                      print('isLoading $isLoading');
                                    },
                                    child: Text(
                                      'Dang nhap',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  )
                                : RaisedButton(
                                    onPressed: () {},
                                    child: Text(
                                      'Dang nhap',
                                    ),
                                  );
                          },
                        ),
                        Text(
                          'tai khoan truong phong: tp',
                          style: TextStyle(color: Colors.red),
                        ),
                        Text(
                          'tai khoan pho phong: pp',
                          style: TextStyle(color: Colors.red),
                        ),
                        Text(
                          'tai khoan nhan vien: nv',
                          style: TextStyle(color: Colors.red),
                        ),
                      ],
                    ),
                    Visibility(
                      visible: isLoading,
                      child: Center(child: CircularProgressIndicator()),
                    )
                  ],
                );
                return content;
              },
            ),
          ),
        ),
      ),
    );
  }
}
