import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_quanly_nhanvien/bloc/room/room_bloc.dart';
import 'package:flutter_quanly_nhanvien/bloc/room/room_event.dart';
import 'package:flutter_quanly_nhanvien/bloc/room/room_state.dart';
import 'package:flutter_quanly_nhanvien/models/models.dart';

class ChangeRoomScreen extends StatefulWidget {
  final Officer officer;

  const ChangeRoomScreen({Key key, this.officer}) : super(key: key);

  @override
  _ChangeRoomScreenState createState() => new _ChangeRoomScreenState();
}

class _ChangeRoomScreenState extends State<ChangeRoomScreen> {
  String _roomChoice;
  RoomBloc _roomBloc;
  Officer _officer;
  List<Room> _listRoom;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _roomBloc = BlocProvider.of<RoomBloc>(context);
    _officer = widget.officer;
    _roomBloc.add(SetRoomChoiceEvent(officer: _officer));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chuyen phong ban'),
      ),
      body: SafeArea(
        child: Container(
          child: Column(
            children: <Widget>[
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text('Chon phong ban de chuyen'),
                  ],
                ),
                decoration: BoxDecoration(color: Colors.green),
              ),
              BlocBuilder(
                bloc: _roomBloc,
                builder: (context, state) {
                  if (state is RoomLoadSuccessState) {
                    _listRoom = state.rooms;
                  }
                  if (state is RoomChoiceLoadSuccessState) {
                    if(_roomChoice != state.roomChoice) {
                      _roomChoice = state.roomChoice;
                      print('aaaaaaaaaaaa');
                    }
                  }
                  var list = Expanded(
                    child: ListView.builder(
                        itemCount: _listRoom?.length ?? 0,
                        itemBuilder: (BuildContext context, index) {
                          return _listItemContent(
                            id: _listRoom[index].id,
                            roomName: _listRoom[index].name,
                            officerList: _listRoom[index].officerList,
                          );
                        }),
                  );
                  return list;
                },
              ),
              RaisedButton(
                onPressed: () {},
                color: Colors.blueAccent,
                child: Text('Luu'),
              ),
              SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }

  _listItemContent({String id, String roomName, List<Officer> officerList}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text(
            '$id - $roomName (co ${officerList != null ? officerList.length : 0} NV)',
            style: TextStyle(fontSize: 18),
          ),
        ),
        Radio(
          value: id,
          groupValue: _roomChoice,
          onChanged: (value) {
            _roomBloc.add(SetRoomChoiceInitialValueEvent(roomChoice: value, officer: _officer));
          },
        ),
      ],
    );
  }

//  _onSaveChangeRoom() {
//    _roomBloc.add(ChangeRoomEvent(abc: value));
//  }
}
