import 'package:flutter/material.dart';
import 'package:flutter_quanly_nhanvien/bloc/room/room_bloc.dart';
import 'package:flutter_quanly_nhanvien/bloc/room/room_event.dart';
import 'package:flutter_quanly_nhanvien/models/models.dart';
import 'package:flutter_quanly_nhanvien/utils/widgets/text_field.dart';

class AddOfficerDialogContent extends StatefulWidget {
  final int roomIndex;
  final RoomBloc roomBloc;

  AddOfficerDialogContent({Key key, this.roomIndex, this.roomBloc})
      : super(key: key);

  @override
  _AddOfficerDialogContentState createState() =>
      new _AddOfficerDialogContentState();
}

class _AddOfficerDialogContentState extends State<AddOfficerDialogContent> {
  final TextEditingController maNVController = new TextEditingController();
  final TextEditingController tenNVController = new TextEditingController();
  String _gender = 'male';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      backgroundColor: Colors.transparent,
      child: Container(
          color: Colors.white,
          width: MediaQuery.of(context).size.width * 5 / 6,
          height: MediaQuery.of(context).size.height * 2.5 / 5,
          child: Column(
            children: <Widget>[
              Container(
                width: double.infinity,
                height: 30,
                color: Colors.green,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'Thong tin nhan vien',
                      style:
                          TextStyle(fontWeight: FontWeight.w500, fontSize: 17),
                    ),
                  ],
                ),
              ),
              textField(
                title: 'Ma NV',
                controller: maNVController,
                onChange: widget.roomBloc.changeMnv,
              ),
              textField(
                title: 'Ten NV',
                controller: tenNVController,
                onChange: widget.roomBloc.changeTnv,
              ),
              InkWell(
                onTap: () {
                  print('aaaaaaaaaaaaaaaaa');
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Container(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Text('Gioi tinh:')),
                    Row(
                      children: <Widget>[
                        Radio(
                          value: 'male',
                          groupValue: _gender,
                          onChanged: (value) {
                            print('1 $value');
                            setState(() {
                              _gender = value;
                            });
                          },
                        ),
                        Padding(padding: EdgeInsets.only(left: 0.0)),
                        Text('Nam'),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Radio(
                          value: 'female',
                          groupValue: _gender,
                          onChanged: (value) {
                            print('2 $value');
                            setState(() {
                              _gender = value;
                            });
                          },
                        ),
                        Padding(padding: EdgeInsets.only(left: 0.0)),
                        Text('Nu'),
                      ],
                    ),
                  ],
                ),
              ),
              StreamBuilder(
                initialData: false,
                stream: widget.roomBloc.validAddOfficerInput,
                builder: (_, data) {
                  var isAddOfficerShow = data.data ?? false;
                  return isAddOfficerShow == true
                      ? RaisedButton(
                          color: Colors.lightBlue,
                          onPressed: () {
                            print('bloc ${widget.roomBloc}');
                            print('aaaaa ${widget.roomIndex}');
                            print(
                                'bbbbbb ${maNVController.text}, ${tenNVController.text},');

                            widget.roomBloc.add(AddOfficerToRoomEvent(
                                widget.roomIndex,
                                Officer(
                                  id: maNVController.text,
                                  name: tenNVController.text,
                                  roomId: (widget.roomIndex).toString(),
                                )));
                                tenNVController.clear();
                                maNVController.clear();
                                widget.roomBloc.changeMpb("");
                                widget.roomBloc.changeTpb("");
                            FocusScope.of(context).unfocus();
                            Navigator.pop(context);
                          },
                          child: Text('Luu nhan vien'),
                        )
                      : RaisedButton(
                          onPressed: () {},
                          child: Text('Luu nhan vien'),
                        );
                },
              ),
            ],
          )),
    );
  }
}
