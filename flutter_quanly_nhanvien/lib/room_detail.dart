import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_quanly_nhanvien/bloc/room/room_bloc.dart';
import 'package:flutter_quanly_nhanvien/bloc/room/room_event.dart';
import 'package:flutter_quanly_nhanvien/bloc/room/room_state.dart';
import 'package:flutter_quanly_nhanvien/models/models.dart';

class RoomDetail extends StatefulWidget {
  final int roomIndex;
  final List<Officer> officerList;

  @override
  _RoomDetailState createState() => new _RoomDetailState();

  RoomDetail({this.roomIndex, this.officerList});
}

class _RoomDetailState extends State<RoomDetail> {
  RoomBloc _roomBloc;
  List<Officer> _officerList;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('Chi tiet phong ban'),
      ),
      body: BlocProvider<RoomBloc>(
        create: (context) => RoomBloc(),
        child: SafeArea(
          child: Container(
            child: Column(
              children: <Widget>[
                Container(
                  color: Colors.green,
                  padding: EdgeInsets.all(8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text('Danh sach nhan vien'),
                    ],
                  ),
                ),
                BlocBuilder(
                  bloc: _roomBloc,
                  builder: (context, state) {
                    var isLoading = state is RoomLoadInProgressState;
                    if (state is RoomLoadFailureState) {
                      return Center(
                        child: Text('Lay thong tin phong ban that bai'),
                      );
                    }
                    _officerList = widget.officerList;
                    if (state is RoomLoadSuccessState) {}
                    var list = Expanded(
                      child: Stack(
                        children: <Widget>[
                          Container(
                            child: ListView.builder(
                              itemCount: _officerList?.length ?? 0,
                              itemBuilder: (BuildContext context, int index) {
                                return (InkWell(
                                  highlightColor: Colors.lightBlueAccent,
                                  radius: 0,
                                  onLongPress: () {
                                    _roomBloc.add(DeleteOfficerFromRoomEvent(
                                        roomIndex: widget.roomIndex,
                                        officer: _officerList[index]));
                                  },
                                  child: Container(
                                    child: _listItemContent(
                                        officer: _officerList[index]),
                                  ),
                                ));
                              },
                            ),
                          ),
                          Visibility(
                            visible: isLoading,
                            child: Center(child: CircularProgressIndicator()),
                          )
                        ],
                      ),
                    );
                    return _officerList != null
                        ? _officerList.length > 0 ? list : Container()
                        : Container(
                            child: Center(
                                child: Text('Phong ban chua co nhan vien')),
                          );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _listItemContent({Officer officer}) {
    return Column(
      children: <Widget>[
        Container(
          padding: EdgeInsets.all(10),
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Text(
                    'Ma NV: ${officer.id}, ',
                    style: TextStyle(fontSize: 18),
                  ),
                  Text(
                    'Ten nhan vien: ${officer.name}',
                    style: TextStyle(fontSize: 18),
                  ),
                ],
              ),
              Row(
                children: <Widget>[
                  Text(
                    'Gioi tinh: ${officer.gender == 'male' ? 'Nam' : 'Nu'}',
                    style: TextStyle(
                        fontSize: 15,
                        fontStyle: FontStyle.italic,
                        color: Colors.deepPurple),
                  ),
                ],
              ),
            ],
          ),
        ),
        Divider(
          height: 1,
          color: Colors.black,
        )
      ],
    );
  }
}
