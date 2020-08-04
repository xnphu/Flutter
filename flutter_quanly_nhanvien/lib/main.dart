import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_quanly_nhanvien/bloc/room/room_bloc.dart';
import 'package:flutter_quanly_nhanvien/bloc/room/room_event.dart';
import 'package:flutter_quanly_nhanvien/bloc/room/room_state.dart';

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

enum GenderCharacter { male, female }

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
  GenderCharacter _genderCharacter = GenderCharacter.male;

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
                  _textField(
                      title: 'Ma phong ban',
                      controller: idController,
                      onChange: (val) {
                        print('$val');
                        _bloc.changeMpb(val);
                      }),
                  _textField(
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
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(5),
                    child: Text('Danh sach phong ban'),
                    decoration: BoxDecoration(color: Colors.green),
                  ),
                  BlocBuilder(
                    bloc: _bloc,
                    builder: (context, state) {
                      var isLoading = state is RoomLoadInProgressState;

                      var list = Expanded(
                        child: Stack(
                          children: <Widget>[
                            Container(
                              child: new ListView.builder(
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
                                                        _dialogContent(
                                                            onTap: () {
                                                              showDialog(
                                                                  context:
                                                                      context,
                                                                  builder:
                                                                      (BuildContext
                                                                          context) {
                                                                    return _addOfficerDialogContent(
                                                                        context:
                                                                            context,
                                                                        roomIndex:
                                                                            index);
                                                                  });
                                                            },
                                                            icon:
                                                                Icon(Icons.add),
                                                            title:
                                                                'Them nhan vien'),
                                                        _dialogContent(
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

                      if (state is RoomLoadFailureState) {
                        return Center(
                          child: Text('Lay thong tin phong that bai'),
                        );
                      }
                      if (state is RoomLoadSuccessState) {
                        _list = state.rooms;
                      }
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

  _textField(
      {String title, TextEditingController controller, Function onChange}) {
    return Padding(
      padding: new EdgeInsets.all(8),
      child: TextField(
        controller: controller,
        onChanged: onChange,
        decoration: InputDecoration(
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
            labelText: '$title'),
      ),
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

  _dialogContent({Function onTap, Icon icon, String title}) {
    return Container(
      child: Column(
        children: <Widget>[
          InkWell(
            highlightColor: Colors.white,
            radius: 0,
            onTap: () {
              if (onTap != null) onTap();
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: <Widget>[
                  icon,
                  Text(title),
                ],
              ),
            ),
          ),
          Divider(
            height: 1,
            color: Colors.black,
          )
        ],
      ),
    );
  }


  _addOfficerDialogContent({BuildContext context, int roomIndex}) {
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
              _textField(
                title: 'Ma NV',
              ),
              _textField(
                title: 'Ten NV',
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Container(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Text('Gioi tinh:')),
                  Row(
                    children: <Widget>[
                      Radio(
                        value: GenderCharacter.male,
                        groupValue: _genderCharacter,
                        onChanged: (GenderCharacter value) {
                          setState(() {
                            _genderCharacter = value;
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
                        value: GenderCharacter.female,
                        groupValue: _genderCharacter,
                        onChanged: (GenderCharacter value) {
                          setState(() {
                            _genderCharacter = value;
                          });
                        },
                      ),
                      Padding(padding: EdgeInsets.only(left: 0.0)),
                      Text('Nu'),
                    ],
                  ),
                ],
              ),
              StreamBuilder(
                initialData: false,
                stream: _bloc.validAddOfficerInput,
                builder: (_, data) {
                  var isAddOfficerShow = data.data ?? false;
                  return isAddOfficerShow == true
                      ? RaisedButton(
                          color: Colors.lightBlue,
                          onPressed: () {
                            print('bloc: $_bloc');
//                                _bloc.add(AddOfficerToRoomEvent(Room(
//                                    id: idController.text,
//                                    name: roomNameController.text)));
//                                idController.clear();
//                                roomNameController.clear();
//                                _bloc.changeMpb("");
//                                _bloc.changeTpb("");
//                                FocusScope.of(context).unfocus();
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
