import 'package:flutter/material.dart';
import 'package:flutter_quanly_nhanvien/screens/detail_room/detail_room_bloc.dart';
import 'package:flutter_quanly_nhanvien/utils/widgets/text_field.dart';

class EditOfficerDialogContent extends StatefulWidget {
  final int index;
  final DetailRoomBloc detailRoomBloc;
  final Function onTapEditOfficer;

  EditOfficerDialogContent({
    Key key,
    this.index,
    this.detailRoomBloc,
    this.onTapEditOfficer,
  }) : super(key: key);

  @override
  _EditOfficerDialogContentState createState() =>
      new _EditOfficerDialogContentState();
}

class _EditOfficerDialogContentState extends State<EditOfficerDialogContent> {
  final TextEditingController maNVController = new TextEditingController();
  final TextEditingController tenNVController = new TextEditingController();
  String _gender = 'male';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    maNVController.text = '${widget.detailRoomBloc.officers[widget.index].id}';
    tenNVController.text =
        '${widget.detailRoomBloc.officers[widget.index].name}';
    _gender = '${widget.detailRoomBloc.officers[widget.index].gender}';
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
                isEnable: false,
              ),
              textField(
                title: 'Ten NV',
                controller: tenNVController,
                onChange: widget.detailRoomBloc.changeTnv,
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
                stream: widget.detailRoomBloc.validEditOfficerInput,
                builder: (_, data) {
                  widget.detailRoomBloc.changeTnv(tenNVController.text);
                  var isEditOfficerShow = data.data ?? false;
                  return isEditOfficerShow == true
                      ? RaisedButton(
                          color: Colors.lightBlue,
                          onPressed: () {
//                            widget.detailRoomBloc.add(EditOfficerEvent(
//                              index: widget.index,
//                              name: tenNVController.text,
//                              gender: _gender,
//                            ));
                            widget.onTapEditOfficer(
                              index: widget.index,
                              name: tenNVController.text,
                              gender: _gender,
                            );
                            tenNVController.clear();
                            widget.detailRoomBloc.changeTnv("");
                            Navigator.pop(context);
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
