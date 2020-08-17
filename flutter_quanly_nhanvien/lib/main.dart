import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_quanly_nhanvien/screens/room/room_bloc.dart';
import 'package:flutter_quanly_nhanvien/screens/room/room_event.dart';
import 'package:flutter_quanly_nhanvien/screens/room/room_state.dart';
import 'package:flutter_quanly_nhanvien/screens/detail_room/room_detail.dart';
import 'package:flutter_quanly_nhanvien/screens/set_position/set_position_screen.dart';
import 'package:flutter_quanly_nhanvien/models/officer.dart';
import 'package:flutter_quanly_nhanvien/utils/widgets/add_officer_dialog_content.dart';
import 'package:flutter_quanly_nhanvien/utils/widgets/dialog_content.dart';
import 'package:flutter_quanly_nhanvien/utils/widgets/text_field.dart';

import 'models/models.dart';
import 'models/room.dart';

void main() {
  runApp(MultiBlocProvider(providers: [
    BlocProvider<RoomBloc>(
      create: (context) => RoomBloc(),
    )
  ], child: MyApp()));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Quan ly nhan vien'),
//      home: BlocProvider<RoomBloc>(
//          create: (context) => RoomBloc(),
//          child: MyHomePage(title: 'Quan ly nhan vien')),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  RoomBloc _bloc;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _bloc = BlocProvider.of<RoomBloc>(context);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _bloc.disPose();
  }

  final TextEditingController idController = new TextEditingController();
  final TextEditingController roomNameController = new TextEditingController();
  bool isButtonEnabled = false;
  final TextEditingController maNVController = new TextEditingController();
  final TextEditingController tenNVController = new TextEditingController();
  List<Room> _list;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: SafeArea(
          child: GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
            },
            child: Container(
//              padding: EdgeInsets.all(10),
              child: Column(
                children: <Widget>[
                  textField(
                      title: 'Ma phong ban',
                      controller: idController,
                      onChange: (val) {
                        _bloc.changeMpb(val);
                      }),
                  textField(
                      title: 'Ten phong ban',
                      controller: roomNameController,
                      onChange: _bloc.changeTpb),
                  StreamBuilder(
                    builder: (_, data) {
                      var isShow = data.data ?? false;
                      return isShow
                          ? RaisedButton(
                              color: Colors.lightBlue,
                              onPressed: () {
                                print('bloc: $_bloc');
                                _bloc.add(RoomAddedEvent(Room(
                                    id: idController.text,
                                    name: roomNameController.text)));
                                idController.clear();
                                roomNameController.clear();
                                _bloc.changeMpb("");
                                _bloc.changeTpb("");
                                FocusScope.of(context).unfocus();
                              },
                              child: Text('Luu phong ban'),
                            )
                          : RaisedButton(
                              onPressed: () {},
                              child: Text('Luu phong ban'),
                            );
                    },
                    initialData: false,
                    stream: _bloc.validInput,
                  ),
                  SizedBox(height: 8),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text('Danh sach phong ban'),
                      ],
                    ),
                    decoration: BoxDecoration(color: Colors.green),
                  ),
                  BlocBuilder(
                    bloc: _bloc,
                    builder: (context, state) {
                      var isLoading = state is RoomLoadInProgressState;
                      if (state is RoomLoadFailureState) {
                        return Center(
                          child: Text('Lay thong tin phong that bai'),
                        );
                      }
                      if (state is RoomLoadSuccessState) {
                        _list = state.rooms;
                      }
                      var list = Expanded(
                        child: Stack(
                          children: <Widget>[
                            Container(
                              child: ListView.builder(
                                  itemCount: _list?.length ?? 0,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return InkWell(
                                      highlightColor: Colors.lightBlueAccent,
                                      radius: 0,
                                      onLongPress: () {
                                        showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return Dialog(
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10)),
                                                backgroundColor:
                                                    Colors.transparent,
                                                child: Container(
                                                    color: Colors.white,
                                                    padding: EdgeInsets.all(8),
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            2 /
                                                            3,
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height *
                                                            1 /
                                                            3,
                                                    child: Column(
                                                      children: <Widget>[
                                                        dialogContent(
                                                            onTap: () {
                                                              _onTapAddOfficer(
                                                                  index: index);
                                                            },
                                                            icon:
                                                                Icon(Icons.add),
                                                            title:
                                                                'Them nhan vien'),
                                                        dialogContent(
                                                            onTap: () {
                                                              _onTapShowOfficerList(
                                                                  context:
                                                                      context,
                                                                  index: index);
                                                            },
                                                            icon: Icon(
                                                                Icons.list),
                                                            title:
                                                                'Danh sach nhan vien'),
                                                        dialogContent(
                                                            onTap: () {
                                                              _onTapSetPosition(
                                                                  context:
                                                                      context,
                                                                  index: index);
                                                            },
                                                            icon: Icon(
                                                                Icons.person),
                                                            title:
                                                                'Lap truong/pho phong'),
                                                        dialogContent(
                                                            onTap: () {
                                                              _onTapDeleteRoom(
                                                                  index: index);
                                                            },
                                                            icon: Icon(
                                                                Icons.delete),
                                                            title: 'Xoa Phong')
                                                      ],
                                                    )),
                                              );
                                            });
                                      },
                                      child: _listItemContent(
                                          id: _list[index].id,
                                          roomName: _list[index].name,
                                          officerList:
                                              _list[index].officerList),
                                    );
                                  }),
                            ),
                            Visibility(
                              child: Center(child: CircularProgressIndicator()),
                              visible: isLoading,
                            )
                          ],
                        ),
                      );

                      return _list != null
                          ? _list.length > 0 ? list : Container()
                          : Container();
                    },
                  ),
                ],
              ),
            ),
          ),
        ) // This trailing comma makes auto-formatting nicer for build methods.
        );
  }

  _listItemContent({String id, String roomName, List<Officer> officerList}) {
    String _truongPhongName='';
    List<Widget> _phoPhongList = [];
    var _listTextStyle = TextStyle(
        fontSize: 15, fontStyle: FontStyle.italic, color: Colors.deepPurple);
    if (officerList == null) officerList = [];
    officerList.asMap().forEach((index, officer) {
      switch (officer.position) {
        case Position.TruongPhong:
          _truongPhongName= '[${officer.name}]';
          break;
        case Position.PhoPhong:
          _phoPhongList.add(Text(
            '- ${officer.name}',
            style: _listTextStyle,
          ));
          break;
        case Position.NhanVien:
          break;
      }
    });
    return Column(
      children: <Widget>[
        Container(
          padding: EdgeInsets.all(10),
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Text(
                    'Ma phong: $id',
                    style: TextStyle(),
                  ),
                  Text(', Ten phong: $roomName'),
                  Text(
                      ' (co: ${officerList != null ? officerList.length : 0} NV)'),
                ],
              ),
              Row(
                children: <Widget>[
                  Text('Truong phong: ${_truongPhongName=='' ? '[Chua co]' : _truongPhongName}',
                      style: TextStyle(
                          fontSize: 15,
                          fontStyle: FontStyle.italic,
                          color: Colors.deepPurple)),
                ],
              ),
              Row(
                children: <Widget>[
                  Text('Pho phong: ${_phoPhongList.length==0 ? '[Chua co]' : ''}',
                      style: TextStyle(
                          fontSize: 15,
                          fontStyle: FontStyle.italic,
                          color: Colors.deepPurple)),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: _phoPhongList,
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

  _onTapDeleteRoom({int index}) {
    _bloc.add(RoomDeletedEvent(index: index));
    Navigator.pop(context);
  }

  _onTapAddOfficer({int index}) {
    print('add nv');
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AddOfficerDialogContent(
            roomIndex: index,
            roomBloc: _bloc,
          );
        });
  }

  _onTapShowOfficerList({BuildContext context, int index}) async {
    Navigator.pop(context);
    List<Officer> listBack = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => RoomDetail(
                  roomIndex: index,
                  officerList: _list[index].officerList,
                )));
    print('list back $listBack');
    if (listBack != null) {
      _bloc.add(RoomModifyEvent(roomIndex: index, officerNewList: listBack));
    }
  }

  _onTapSetPosition({BuildContext context, int index}) async {
    Navigator.pop(context);
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => SetPositionScreen(
                  roomIndex: index,
                )));
  }
}
