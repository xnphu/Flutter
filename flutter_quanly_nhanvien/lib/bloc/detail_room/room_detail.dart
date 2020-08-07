import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_quanly_nhanvien/bloc/detail_room/detail_room_bloc.dart';
import 'package:flutter_quanly_nhanvien/bloc/detail_room/detail_room_event.dart';
import 'package:flutter_quanly_nhanvien/bloc/detail_room/detail_room_state.dart';
import 'package:flutter_quanly_nhanvien/bloc/room/room_bloc.dart';
import 'package:flutter_quanly_nhanvien/models/models.dart';

class RoomDetail extends StatefulWidget {
  final int roomIndex;
  final List<Officer> officerList;

  @override
  _RoomDetailState createState() => new _RoomDetailState();

  RoomDetail({this.roomIndex, this.officerList});
}

class _RoomDetailState extends State<RoomDetail> {
  DetailRoomBloc _detailRoomBloc;
  List<Officer> _officerList;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _detailRoomBloc = DetailRoomBloc();
    _detailRoomBloc.add(DetailRoomInitialEvent(
        officers: widget.officerList == null ? [] : widget.officerList));
//    var x = BlocProvider.of<RoomBloc>(context);
//    print('xxxxxxxxxx: ${x}');
//    _detailRoomBloc = BlocProvider.of<DetailRoomBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('Chi tiet phong ban'),
      ),
      body: BlocProvider<DetailRoomBloc>(
        create: (context) => _detailRoomBloc,
        child: WillPopScope(
          onWillPop: () {
            Navigator.pop(context, _officerList);
            return;
          },
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
                    bloc: _detailRoomBloc,
                    builder: (context, state) {
                      print('state: ${state.officers}');
                      var isLoading = state is DetailRoomLoadInProgressState;
                      if (state is DetailRoomLoadInProgressState) {
                        return Center(child: CircularProgressIndicator());
                      }
                      if (state is DetailRoomLoadFailureState) {
                        return Center(
                          child: Text('Lay thong tin phong ban that bai'),
                        );
                      }
                      if (state is DetailRoomLoadSuccessState) {
                        _officerList = state.officers;
                      }
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
                                      _detailRoomBloc.add(
                                          DeleteOfficerEvent(index: index));
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
