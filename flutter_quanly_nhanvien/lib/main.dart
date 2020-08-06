import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_quanly_nhanvien/bloc/room/room_bloc.dart';
import 'package:flutter_quanly_nhanvien/bloc/room/room_event.dart';
import 'package:flutter_quanly_nhanvien/bloc/room/room_state.dart';
import 'package:flutter_quanly_nhanvien/room_detail.dart';
import 'package:flutter_quanly_nhanvien/utils/widgets/add_officer_dialog_content.dart';
import 'package:flutter_quanly_nhanvien/utils/widgets/dialog_content.dart';
import 'package:flutter_quanly_nhanvien/utils/widgets/text_field.dart';

import 'models/models.dart';
import 'models/room.dart';

void main() {
  runApp(MyApp());
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
      home: BlocProvider<RoomBloc>(
          create: (context) => RoomBloc(),
          child: MyHomePage(title: 'Quan ly nhan vien')),
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
              padding: EdgeInsets.all(10),
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
                                                              print('add nv');
                                                              showDialog(
                                                                  context:
                                                                      context,
                                                                  builder:
                                                                      (BuildContext
                                                                          context) {
                                                                    return AddOfficerDialogContent(
                                                                      roomIndex:
                                                                          index,
                                                                      roomBloc:
                                                                          _bloc,
                                                                    );
                                                                  });
                                                            },
                                                            icon:
                                                                Icon(Icons.add),
                                                            title:
                                                                'Them nhan vien'),
                                                        dialogContent(
                                                            onTap: () async {
                                                              Navigator.pop(context);
                                                              Navigator.push(
                                                                  context,
                                                                  MaterialPageRoute(
                                                                      builder: (context) =>
                                                                          RoomDetail(
                                                                            roomIndex:
                                                                                index,
                                                                            officerList:
                                                                                _list[index].officerList,
                                                                          )));
                                                            },
                                                            icon: Icon(
                                                                Icons.list),
                                                            title:
                                                                'Danh sach nhan vien'),
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
    return Column(
      children: <Widget>[
        Container(
          padding: EdgeInsets.all(10),
          child: Row(
            children: <Widget>[
              Text(
                'Ma phong: $id',
                style: TextStyle(),
              ),
              Text(', Ten phong: $roomName'),
              Text(' (co: ${officerList != null ? officerList.length : 0} NV)'),
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
}
