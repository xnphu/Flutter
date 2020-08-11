import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_quanly_nhanvien/bloc/change_room/change_room_screen.dart';
import 'package:flutter_quanly_nhanvien/bloc/detail_room/detail_room_bloc.dart';
import 'package:flutter_quanly_nhanvien/bloc/detail_room/detail_room_event.dart';
import 'package:flutter_quanly_nhanvien/bloc/detail_room/detail_room_state.dart';
import 'package:flutter_quanly_nhanvien/bloc/room/room_bloc.dart';
import 'package:flutter_quanly_nhanvien/models/models.dart';
import 'package:flutter_quanly_nhanvien/utils/widgets/add_officer_dialog_content.dart';
import 'package:flutter_quanly_nhanvien/utils/widgets/dialog_content.dart';
import 'package:flutter_quanly_nhanvien/utils/widgets/edit_officer_dialog_content.dart';

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
    return WillPopScope(
      onWillPop: () {
        Navigator.pop(context, _officerList);
        return;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('Chi tiet phong ban'),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context, _officerList);
            },
          ),
        ),
        body: BlocProvider<DetailRoomBloc>(
          create: (context) => _detailRoomBloc,
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
                      if (state is RemoveSuccessState) {
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
                                      showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return Dialog(
                                              backgroundColor:
                                                  Colors.transparent,
                                              child: Container(
                                                color: Colors.white,
                                                padding: EdgeInsets.all(8),
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    2 /
                                                    3,
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    1 /
                                                    3,
                                                child: Column(
                                                  children: <Widget>[
                                                    dialogContent(
                                                        title: 'Sua nhan vien',
                                                        icon: Icon(
                                                            Icons.mode_edit),
                                                        onTap: () {
                                                          _onTapEditOfficerDialog(
                                                              context: context,
                                                              index: index);
                                                        }),
                                                    dialogContent(
                                                        title:
                                                            'Chuyen phong ban',
                                                        icon: Icon(
                                                            Icons.next_week),
                                                        onTap: () {
                                                          _onTapMoveOfficer(context: context, index: index);
                                                        }),
                                                    dialogContent(
                                                        title: 'Xoa nhan vien',
                                                        icon:
                                                            Icon(Icons.delete),
                                                        onTap: () {
                                                          _onTapDeleteOfficer(
                                                              context: context,
                                                              index: index,
                                                              officers:
                                                                  _officerList);
                                                        }),
                                                  ],
                                                ),
                                              ),
                                            );
                                          });
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
                          ? _officerList.length > 0
                              ? list
                              : Container(
                                  child: Center(
                                      child:
                                          Text('Phong ban chua co nhan vien')),
                                )
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
                  officer.gender == 'male'
                      ? Icon(
                          Icons.person,
                          color: Colors.blue,
                        )
                      : Icon(
                          Icons.person,
                          color: Colors.red,
                        ),
                  Text(
                    ' Ma NV: ${officer.id}, ',
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

  _onTapDeleteOfficer(
      {BuildContext context, int index, List<Officer> officers}) {
    Widget cancelButton = FlatButton(
      child: Text("Khong"),
      onPressed: () {
        Navigator.pop(context);
      },
    );
    Widget continueButton = FlatButton(
      child: Text("Co"),
      onPressed: () {
        _detailRoomBloc.add(DeleteOfficerEvent(index: index));
        Navigator.pop(context);
        Navigator.pop(context);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Xoa nhan vien"),
      content: Text(
          "ban co chac chan muon xoa nhan vien '${officers[index].name}' ?"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
//    }
  }

  _onTapEditOfficerDialog({BuildContext context, int index}) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return EditOfficerDialogContent(
            index: index,
            detailRoomBloc: _detailRoomBloc,
            onTapEditOfficer: _onTapEditOfficer,
          );
        });
  }

  _onTapEditOfficer(
      {BuildContext context, int index, String name, String gender}) {
    _detailRoomBloc.add(EditOfficerEvent(
      index: index,
      name: name,
      gender: gender,
    ));
  }

  _onTapMoveOfficer({
    BuildContext context,
    int index,
  }) {
    Navigator.pop(context);
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => ChangeRoomScreen(
      officer: _officerList[index],
    )));
  }
}
