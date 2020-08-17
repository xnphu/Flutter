import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_quanly_nhanvien/bloc/room/room_bloc.dart';
import 'package:flutter_quanly_nhanvien/bloc/room/room_event.dart';
import 'package:flutter_quanly_nhanvien/bloc/room/room_state.dart';
import 'package:flutter_quanly_nhanvien/models/officer.dart';

class SetPositionScreen extends StatefulWidget {
  final int roomIndex;

  const SetPositionScreen({Key key, this.roomIndex}) : super(key: key);

  @override
  _SetPositionScreen createState() => new _SetPositionScreen();
}

class _SetPositionScreen extends State<SetPositionScreen> {
  RoomBloc _roomBloc;
  List<Officer> _officerList;
  int _roomIndex;
  String _truongPhongID;
  List<bool> checkBoxValue = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _roomIndex = widget.roomIndex;
    _roomBloc = BlocProvider.of(context);
    _roomBloc
        .add(SetPositionScreenLoadSuccessEvent(roomIndex: widget.roomIndex));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Thiet lap truong/pho phong'),
      ),
      body: SafeArea(
        child: Container(
          child: Column(
            children: <Widget>[
              _header(title: 'Chon truong phong'),
              BlocBuilder(
                bloc: _roomBloc,
                builder: (context, state) {
                  if (state is SetPositionScreenLoadSuccessState) {
                    _officerList = state.officers;
                    _setRadioValue();
                  }
                  var list = Expanded(
                    child: ListView.builder(
                        itemCount: _officerList?.length ?? 0,
                        itemBuilder: (BuildContext context, index) {
                          return _listTruongPhongContent(
                              id: _officerList[index].id,
                              name: _officerList[index].name,
                              position: _officerList[index].position,
                              index: index);
                        }),
                  );
                  return list;
                },
              ),
              _header(title: 'Chon pho phong'),
              BlocBuilder(
                bloc: _roomBloc,
                builder: (context, state) {
                  if (state is SetPositionScreenLoadSuccessState) {
                    _officerList = state.officers;
                    _setRadioValue();
                  }
                  var list = Expanded(
                    child: ListView.builder(
                        itemCount: _officerList?.length ?? 0,
                        itemBuilder: (BuildContext context, index) {
                          return _listPhoPhongContent(
                            id: _officerList[index].id,
                            name: _officerList[index].name,
                            position: _officerList[index].position,
                            index: index,
                          );
                        }),
                  );
                  return list;
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  _header({String title}) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(title),
        ],
      ),
      decoration: BoxDecoration(color: Colors.green),
    );
  }

  _listTruongPhongContent(
      {String id, String name, Position position, int index}) {
    String positionString;
    switch (position) {
      case Position.NhanVien:
        positionString = 'Nhan Vien';
        break;
      case Position.TruongPhong:
        positionString = 'Truong Phong';
        _truongPhongID = id;
        break;
      case Position.PhoPhong:
        positionString = 'Pho Phong';
        break;
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text(
            '$id - $name - chuc vu $positionString',
            style: TextStyle(fontSize: 18),
          ),
        ),
        Radio(
          value: id,
          groupValue: _truongPhongID,
          onChanged: (value) {
            setState(() {
              _truongPhongID = value;
            });
            _roomBloc.add(SetTruongPhongEvent(
                roomIndex: _roomIndex, officerIndex: index));
          },
        ),
      ],
    );
  }

  _listPhoPhongContent({String id, String name, Position position, int index}) {
    String positionString;
    checkBoxValue.add(false);
    switch (position) {
      case Position.NhanVien:
        positionString = 'Nhan Vien';
        break;
      case Position.TruongPhong:
        positionString = 'Truong Phong';
        checkBoxValue[index] = false;
        _truongPhongID = id;
        break;
      case Position.PhoPhong:
        positionString = 'Pho Phong';
        checkBoxValue[index] = true;
        break;
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text(
            '$id - $name - chuc vu $positionString',
            style: TextStyle(fontSize: 18),
          ),
        ),
        Checkbox(
          value: checkBoxValue[index],
          onChanged: (value) {
            setState(() {
              checkBoxValue[index] = value;
              if (value == true) {
                _truongPhongID = '';
              }
            });
            _roomBloc.add(SetPhoPhongEvent(
                roomIndex: _roomIndex, officerIndex: index, isSelected: value));
          },
        ),
      ],
    );
  }

  void _setRadioValue() {
    _officerList.forEach((officer) {
      if (officer.position == Position.TruongPhong) {
        _truongPhongID = officer.id;
      }
    });
  }
}
