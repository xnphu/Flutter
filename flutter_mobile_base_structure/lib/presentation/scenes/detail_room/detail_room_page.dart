import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_mobile_base_structure/domain/model/index.dart';
import 'package:flutter_mobile_base_structure/presentation/base/base_bloc.dart';
import 'package:flutter_mobile_base_structure/presentation/base/base_event.dart';
import 'package:flutter_mobile_base_structure/presentation/base/base_page.dart';
import 'package:flutter_mobile_base_structure/presentation/base/base_page_mixin.dart';
import 'package:flutter_mobile_base_structure/presentation/base/base_state.dart';
import 'package:flutter_mobile_base_structure/presentation/scenes/change_room/change_room_page.dart';
import 'package:flutter_mobile_base_structure/presentation/scenes/detail_room/detail_room_bloc.dart';
import 'package:flutter_mobile_base_structure/presentation/scenes/detail_room/detail_room_event.dart';
import 'package:flutter_mobile_base_structure/presentation/scenes/detail_room/detail_room_router.dart';
import 'package:flutter_mobile_base_structure/presentation/scenes/home/home_bloc.dart';
import 'package:flutter_mobile_base_structure/presentation/widgets/dialog_content.dart';
import 'package:flutter_mobile_base_structure/presentation/widgets/edit_officer_dialog_content.dart';

import 'detail_room_state.dart';

class DetailRoomPage extends BasePage {
  final int roomIndex;

  DetailRoomPage({this.roomIndex});

  @override
  State<StatefulWidget> createState() => DetailRoomPageState();
}

class DetailRoomPageState
    extends BasePageState<DetailRoomBloc, DetailRoomPage, DetailRoomRouter> {
  DetailRoomBloc _bloc;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget buildBody(BuildContext context, BaseBloc<BaseEvent, BaseState> bloc) {
    // TODO: implement buildBody
    return _buildDetailRoomPage(context, bloc);
  }

  _buildDetailRoomPage(BuildContext context, DetailRoomBloc bloc) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    _bloc = bloc;
    _bloc.add(DetailRoomInitialEvent(index: widget.roomIndex));
    List _officerList = [];
    return Scaffold(
      body: SafeArea(
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
                bloc: _bloc,
                builder: (context, state) {
                  var isLoading = state is DetailRoomLoadInProgressState;
                  if (state is DetailRoomLoadSuccessState) {
                    _officerList = state.officerList;
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
                                          backgroundColor: Colors.transparent,
                                          child: Container(
                                            color: Colors.white,
                                            padding: EdgeInsets.all(8),
                                            width: screenWidth * 2 / 3,
                                            height: screenHeight * 1 / 3,
                                            child: Column(
                                              children: <Widget>[
                                                dialogContent(
                                                    title: 'Sua nhan vien',
                                                    icon: Icon(Icons.mode_edit),
                                                    onTap: () {
                                                      _onTapEditOfficerDialog(
                                                          context: context,
                                                          index: index);
                                                    }),
                                                dialogContent(
                                                    title: 'Chuyen phong ban',
                                                    icon: Icon(Icons.next_week),
                                                    onTap: () {
                                                        _onTapMoveOfficer(
                                                            context: context,
                                                            index: index);
                                                    }),
                                                dialogContent(
                                                    title: 'Xoa nhan vien',
                                                    icon: Icon(Icons.delete),
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
                                  child: Text('Phong ban chua co nhan vien')),
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
        _bloc
            .add(DeleteOfficerEvent(roomIndex: widget.roomIndex, index: index));
        Navigator.pop(context);
        Navigator.pop(context);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Xoa nhan vien"),
      content: Text(
          "Ban co chac chan muon xoa nhan vien '${officers[index].name}' ?"),
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
  }

  _onTapEditOfficerDialog({BuildContext context, int index}) {
    Stream<bool> validEditOfficerInput = _bloc.validEditOfficerInput;
    Function changeTnv = _bloc.changeTnv;
    String id = _bloc.officerListLocal[index].id;
    String name = _bloc.officerListLocal[index].name;
    String gender = _bloc.officerListLocal[index].gender;
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return EditOfficerDialogContent(
            index: index,
            onTapEditOfficer: _onTapEditOfficer,
            validEditOfficerInput: validEditOfficerInput,
            changeTnv: changeTnv,
            id: id,
            name: name,
            gender: gender,
          );
        });
  }

  _onTapEditOfficer(
      {BuildContext context, int index, String name, String gender}) {
    _bloc.add(EditOfficerEvent(
      index: index,
      roomIndex: widget.roomIndex,
      name: name,
      gender: gender,
    ));
  }

  _onTapMoveOfficer({
    BuildContext context,
    int index,
  }) async{
    //hide dialog
    Navigator.pop(context);
    navigator.materialPush(context: context, page: ChangeRoomPage());
//    var listBack = await Navigator.push(
//        context, MaterialPageRoute(builder: (context) => ChangeRoomScreen(
//      officer: _officerList[index],
//      roomIndex: _roomIndex,
//    )));
//    print('listBack $listBack');
//    _detailRoomBloc.add(ChangeRoomSuccessEvent(officers: listBack));
  }
}
