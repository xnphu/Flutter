import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_trip_challenger/utils/hex_color.dart';
import 'package:flutter_trip_challenger/utils/support_device.dart';
import 'package:flutter_trip_challenger/utils/widgets/text_field_with_icon.dart';


class RegisterPage extends StatefulWidget {
  RegisterPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

enum GenderCharacter { male, female }

class _RegisterPageState extends State<RegisterPage> {
  final fullName = TextEditingController();
  final email = TextEditingController();
  final password = TextEditingController();
  final height = TextEditingController();
  final weight = TextEditingController();
  final calendar = TextEditingController();
  String emailHolder = '';
  String passwordHolder = '';
  String dateOfBirth;
  GenderCharacter _character = GenderCharacter.male;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register'),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
            height: MediaQuery.of(context).size.height,
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'REGISTER',
                      style: TextStyle(
                        color: Colors.orange,
                        fontSize: 30,
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 0, vertical: 10),
                  child: Container(
                    width: mWidth(context: context, width: 335),
//                    height: mHeight(context: context, height: 500),
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                            color:
                                Color.fromARGB((0.25 * 255).toInt(), 0, 0, 0),
                            offset: Offset(0, 4),
                            blurRadius: 4)
                      ],
                      gradient: LinearGradient(
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                          colors: [HexColor('#FFE2AA'), HexColor('#FDD9A1')]),
                      borderRadius: BorderRadius.circular(26),
                    ),
                    child: Stack(
                      alignment: Alignment.center,
                      children: <Widget>[
                        Positioned(
                          bottom: 5,
                          child: Image(
                            image: AssetImage('assets/images/flash-grey.png'),
                            fit: BoxFit.cover,
                          ),
                        ),
                        Container(
                          width: mWidth(context: context, width: 330),
                          padding: EdgeInsets.symmetric( vertical: 10, horizontal: 10),
                          child: Column(
//                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              textFieldWithIcon('Full name', false, fullName,
                                  Icon(Icons.person)),
                              textFieldWithIcon('Email address', false, email,
                                  Icon(Icons.mail_outline)),
                              textFieldWithIcon('Password', true, password,
                                  Icon(Icons.lock_outline)),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Expanded(
                                    child: textFieldWithIcon('Height', false, height,
                                        Icon(Icons.lock_outline)),
                                  ),
                                  SizedBox(width: 50),
                                  Expanded(
                                    child: textFieldWithIcon('Weight', false, weight,
                                        Icon(Icons.lock_outline)),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Expanded(
                                    child: GestureDetector(
                                      onTap: () {
                                        DatePicker.showDatePicker(context,
                                            showTitleActions: true,
                                            onChanged: (date) {
                                              print('change $date');
                                            },
                                            theme: DatePickerTheme(
                                              backgroundColor: HexColor('#FEDCA4')
                                            ),
                                            onConfirm: (date) {
//                                              calendar.text = date.toString();
                                              setState(() {
                                                dateOfBirth = date.toString().substring(0,10);
                                              });
                                            },
                                            locale: LocaleType.en);
                                      },
                                      child: Column(
                                        children: <Widget>[
                                          Text('Date of birth'),
                                          Row(
                                            children: <Widget>[
                                              Icon(Icons.calendar_today),
                                              SizedBox(width: 20),
                                              Text(dateOfBirth != null ? '$dateOfBirth' : 'Date of birth', )
                                            ],
                                          ),
                                        ],
                                      )
                                    ),
                                  ),
                                  SizedBox(width: 15),
                                  Expanded(
                                    child: Column(
                                      children: <Widget>[
                                        Row(
                                          children: <Widget>[
                                            Radio(
                                              focusColor: HexColor('#FEC151'),
                                              value: GenderCharacter.male,
                                              groupValue: _character,
                                              onChanged: (GenderCharacter value) {
                                                setState(() {
                                                  _character = value;
                                                });
                                              },
                                            ),
                                            Padding(padding: EdgeInsets.only(left: 0.0)),
                                            Text('Male'),
                                          ],
                                        ),
                                        Row(
                                          children: <Widget>[
                                            Radio(
                                              focusColor: HexColor('#FEC151'),
                                              value: GenderCharacter.female,
                                              groupValue: _character,
                                              onChanged: (GenderCharacter value) {
                                                setState(() {
                                                  _character = value;
                                                });
                                              },
                                            ),
                                            Padding(padding: EdgeInsets.only(left: 0.0)),
                                            Text('Female'),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
