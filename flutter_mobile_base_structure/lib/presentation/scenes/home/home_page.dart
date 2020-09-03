import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_mobile_base_structure/domain/model/index.dart';
import 'package:flutter_mobile_base_structure/presentation/app/application_bloc.dart';
import 'package:flutter_mobile_base_structure/presentation/base/base_bloc.dart';
import 'package:flutter_mobile_base_structure/presentation/base/base_event.dart';
import 'package:flutter_mobile_base_structure/presentation/base/base_page.dart';
import 'package:flutter_mobile_base_structure/presentation/base/base_page_mixin.dart';
import 'package:flutter_mobile_base_structure/presentation/base/base_state.dart';
import 'package:flutter_mobile_base_structure/presentation/scenes/detail_room/detail_room_page.dart';
import 'package:flutter_mobile_base_structure/presentation/scenes/home/home_router.dart';
import 'package:flutter_mobile_base_structure/presentation/scenes/home/index.dart';
import 'package:flutter_mobile_base_structure/presentation/scenes/login/index.dart';
import 'package:flutter_mobile_base_structure/presentation/scenes/set_position/index.dart';
import 'package:flutter_mobile_base_structure/presentation/widgets/add_officer_dialog_content.dart';
import 'package:flutter_mobile_base_structure/presentation/widgets/dialog_content.dart';
import 'package:flutter_mobile_base_structure/presentation/widgets/text_field.dart';

class HomePage extends BasePage {
  HomePage({Key key, this.username}) : super(key: key);
  final String username;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends BasePageState<HomeBloc, HomePage, HomeRouter> {
  HomeBloc _bloc;
  List<Room> _list;
  String _username;
  final TextEditingController idController = new TextEditingController();
  final TextEditingController roomNameController = new TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    idController.dispose();
    roomNameController.dispose();
    _bloc.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    bloc.add(HomeInitialEvent());
    _username = widget.username;
  }

  @override
  Widget buildBody(BuildContext context, BaseBloc<BaseEvent, BaseState> bloc) {
    // TODO: implement buildBody
    return _buildHomePage(context, bloc);
  }

  _buildHomePage(BuildContext context, HomeBloc bloc) {
    _bloc = bloc;
//    _bloc.add(HomeInitialEvent());
    return Scaffold(
      body: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
//          decoration: BoxDecoration(
//            gradient: LinearGradient(
//                colors: [AppColors.secondaryColor, AppColors.primaryColor],
//                begin: Alignment.topLeft,
//                end: Alignment.bottomRight),
//          ),
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {
                        _bloc.add(LogOutEvent());
                        navigator.materialPushAndRemoveAll(context: context, page: LoginPage());
                      },
                      child: Text('Dang xuat',
                      style: TextStyle(
                       color: Colors.red
                      )),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: buildHeader(
                    title: 'Quan ly nhan vien',
                    textStyle: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    )),
              ),
              _username == 'tp'
                  ? Column(
                      children: <Widget>[
                        textField(
                            title: 'Ma phong ban',
                            controller: idController,
                            onChange: _bloc.changeMpb),
                        textField(
                            title: 'Ten phong ban',
                            controller: roomNameController,
                            onChange: _bloc.changeTpb),
                        _buildAddRoomButton(),
                        SizedBox(
                          height: 10,
                        ),
                      ],
                    )
                  : Container(),
              buildHeader(
                  title: 'Danh sach phong ban',
                  color: Colors.green,
                  textStyle: TextStyle(fontSize: 17)),
              BlocBuilder(
                bloc: _bloc,
                builder: (context, state) {
                  var isLoading = state is HomeLoadInProgressState;
                  if (state is HomeLoadFailureState) {
                    return Center(
                      child: Text('Lay thong tin phong that bai'),
                    );
                  }
                  if (state is HomeLoadSuccessState) {
                    _list = state.rooms;
                  }
                  var list = Expanded(
                    child: Stack(
                      children: <Widget>[
                        Container(
                          child: ListView.builder(
                              itemCount: _list?.length ?? 0,
                              itemBuilder: (BuildContext context, int index) {
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
                                                    BorderRadius.circular(10)),
                                            backgroundColor: Colors.transparent,
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
                                                child:
                                                    _dialogContentBaseOnUsername(
                                                        username: _username,
                                                        listIndex: index)),
                                          );
                                        });
                                  },
                                  child: _listItemContent(
                                      id: _list[index].id,
                                      roomName: _list[index].name,
                                      officerList: _list[index].officerList),
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
    );
  }

  buildHeader({String title, Color color, TextStyle textStyle}) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(title, style: textStyle),
        ],
      ),
      decoration: BoxDecoration(color: color),
    );
  }

  _buildAddRoomButton() {
    return Container(
      child: StreamBuilder(
        stream: _bloc.validInput,
        initialData: false,
        builder: (_, data) {
          var isShow = data.data ?? false;
          final titleStyle = getTextStyle(
              color: isShow ? AppColors.secondaryColor : AppColors.lightBlack50,
              fontSize: 17,
              fontFamily: AppFonts.sfProText,
              fontWeight: FontWeight.w600);
          return isShow
              ? RoundedTextButton(
                  title: 'Luu phong ban',
                  textStyle: titleStyle,
                  onPressed: () {
                    _bloc.add(AddRoomEvent(Room(
                        id: idController.text, name: roomNameController.text)));
                    _clearTextField();
                  },
                  backgroundColor: Colors.white,
                  allRadius: 27,
                )
              : RoundedTextButton(
                  title: 'Luu phong ban',
                  textStyle: titleStyle,
                  onPressed: () {},
                  backgroundColor: Colors.white,
                  allRadius: 27,
                );
        },
      ),
    );
  }

  _clearTextField() {
    idController.clear();
    roomNameController.clear();
    _bloc.changeMpb("");
    _bloc.changeTpb("");
    FocusScope.of(context).unfocus();
  }

  _listItemContent({String id, String roomName, List<Officer> officerList}) {
    String _truongPhongName = '';
    List<Widget> _phoPhongList = [];
    var _listTextStyle = TextStyle(
        fontSize: 15, fontStyle: FontStyle.italic, color: Colors.deepPurple);
    if (officerList == null) officerList = [];
    officerList.asMap().forEach((index, officer) {
      switch (officer.position) {
        case Position.TruongPhong:
          _truongPhongName = '[${officer.name}]';
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
                  Text(
                      'Truong phong: ${_truongPhongName == '' ? '[Chua co]' : _truongPhongName}',
                      style: TextStyle(
                          fontSize: 15,
                          fontStyle: FontStyle.italic,
                          color: Colors.deepPurple)),
                ],
              ),
              Row(
                children: <Widget>[
                  Text(
                      'Pho phong: ${_phoPhongList.length == 0 ? '[Chua co]' : ''}',
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
    _bloc.add(DeleteRoomEvent(index: index));
    Navigator.pop(context);
  }

  _onTapAddOfficer({int index}) {
    Stream<bool> validAddOfficerInput = _bloc.validAddOfficerInput;
    Function changeMnv = _bloc.changeMnv;
    Function changeTnv = _bloc.changeTnv;
    disposeStream() {
      _bloc.disposeAddOfficer();
    }

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AddOfficerDialogContent(
            roomIndex: index,
            validAddOfficerInput: validAddOfficerInput,
            changeMnv: changeMnv,
            changeTnv: changeTnv,
            addOfficerToRoomEvent: (officer) {
              print('officer $officer');
              _bloc.add(
                  AddOfficerToRoomEvent(roomIndex: index, officer: officer));
            },
            disposeStream: disposeStream,
          );
        });
  }

  _onTapShowOfficerList({BuildContext context, int index}) async {
    Navigator.pop(context);
    List<Officer> listBack = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => DetailRoomPage(
              roomIndex: index,
            )));
    print('listBack $listBack');
    if(listBack==null) {
      _bloc.add(HomeInitialEvent());
    }
  }

  _onTapSetPosition({BuildContext context, int index}) async {
    Navigator.pop(context);
    var resultBack = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => SetPositionPage(
              roomIndex: index,
            )));
    if(resultBack==null) {
      _bloc.add(HomeInitialEvent());
    }
  }

  _dialogContentBaseOnUsername({String username, int listIndex}) {
    switch (username) {
      case 'tp':
        return Column(
          children: <Widget>[
            dialogContent(
                onTap: () {
                  _onTapAddOfficer(index: listIndex);
                },
                icon: Icon(Icons.add),
                title: 'Them nhan vien'),
            dialogContent(
                onTap: () {
                  _onTapShowOfficerList(context: context, index: listIndex);
                },
                icon: Icon(Icons.list),
                title: 'Danh sach nhan vien'),
            dialogContent(
                onTap: () {
                  _onTapSetPosition(context: context, index: listIndex);
                },
                icon: Icon(Icons.person),
                title: 'Lap truong/pho phong'),
            dialogContent(
                onTap: () {
                  _onTapDeleteRoom(index: listIndex);
                },
                icon: Icon(Icons.delete),
                title: 'Xoa Phong')
          ],
        );
        break;
      case 'pp':
        return Column(
          children: <Widget>[
            dialogContent(
                onTap: () {
                  _onTapAddOfficer(index: listIndex);
                },
                icon: Icon(Icons.add),
                title: 'Them nhan vien'),
            dialogContent(
                onTap: () {
                  _onTapShowOfficerList(context: context, index: listIndex);
                },
                icon: Icon(Icons.list),
                title: 'Danh sach nhan vien'),
          ],
        );
        break;
      default:
        return Column(
          children: <Widget>[
            dialogContent(
                onTap: () {
                  _onTapShowOfficerList(context: context, index: listIndex);
                },
                icon: Icon(Icons.list),
                title: 'Danh sach nhan vien'),
          ],
        );
        break;
    }
  }
}
