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

enum Position { TruongPhong, PhoPhong }

class _SetPositionScreen extends State<SetPositionScreen> {
  RoomBloc _roomBloc;
  List<Officer> _officerList;
  String _truongPhongRadioValue;
  List<bool> checkBoxValue = [false, false];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
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
                  }
                  var list = Expanded(
                    child: ListView.builder(
                        itemCount: _officerList?.length ?? 0,
                        itemBuilder: (BuildContext context, index) {
                          return _listTruongPhongContent(
                            id: _officerList[index].id,
                            name: _officerList[index].name,
                            position: _officerList[index].position,
                          );
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

  _listTruongPhongContent({String id, String name, String position}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text(
            '$id - $name - chuc vu ${position ?? 'Nhan vien'}',
            style: TextStyle(fontSize: 18),
          ),
        ),
        Radio(
          value: id,
          groupValue: _truongPhongRadioValue,
          onChanged: (value) {
            setState(() {
              _truongPhongRadioValue = value;
            });
          },
        ),
      ],
    );
  }

  _listPhoPhongContent({String id, String name, String position, int index}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text(
            '$id - $name - chuc vu ${position ?? 'Nhan vien'}',
            style: TextStyle(fontSize: 18),
          ),
        ),
        Checkbox(
          value: checkBoxValue[index],
          onChanged: (value) {
            setState(() {
              checkBoxValue[index]=value;
            });
          },
        ),
      ],
    );
  }
}
