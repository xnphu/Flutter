import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_mobile_base_structure/domain/model/index.dart';
import 'package:flutter_mobile_base_structure/presentation/base/base_bloc.dart';
import 'package:flutter_mobile_base_structure/presentation/base/base_event.dart';
import 'package:flutter_mobile_base_structure/presentation/base/base_page.dart';
import 'package:flutter_mobile_base_structure/presentation/base/base_page_mixin.dart';
import 'package:flutter_mobile_base_structure/presentation/base/base_state.dart';
import 'package:flutter_mobile_base_structure/presentation/scenes/change_room/index.dart';

class ChangeRoomPage extends BasePage {
  final Officer officer;
  final int roomIndex;

  ChangeRoomPage({this.officer, this.roomIndex});

  @override
  State<StatefulWidget> createState() => ChangeRoomPageState();
}

class ChangeRoomPageState
    extends BasePageState<ChangeRoomBloc, ChangeRoomPage, ChangeRoomRouter> {
  ChangeRoomBloc _bloc;
  String _roomChoice;
  Officer _officer;
  int _roomIndex;
  List<Room> _listRoom;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _officer = widget.officer;
    _roomIndex = widget.roomIndex;
  }

  @override
  Widget buildBody(BuildContext context, BaseBloc<BaseEvent, BaseState> bloc) {
    // TODO: implement buildBody
    return _buildDetailRoomPage(context, bloc);
  }

  _buildDetailRoomPage(BuildContext context, ChangeRoomBloc bloc) {
    _bloc = bloc;
    _bloc.add(ChangeRoomInitialEvent());
    _bloc.add(SetRoomChoiceInitialEvent(officer: _officer));

    return WillPopScope(
      onWillPop: () {
        Navigator.pop(context, _roomIndex);
        return;
      },
      child: Scaffold(
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
                  bloc: _bloc,
                  builder: (context, state) {
                    if (state is ChangeRoomLoadSuccessState) {
                      _listRoom = state.rooms;
                      _roomChoice = state.roomChoice;
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
//                RaisedButton(
//                  onPressed: () {
//                    Navigator.pop(context, _roomIndex);
//                  },
//                  color: Colors.blueAccent,
//                  child: Text('Luu'),
//                ),
//                SizedBox(height: 10),
              ],
            ),
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
            _bloc.add(SetRoomChoiceEvent(roomChoice: value, officer: _officer));
          },
        ),
      ],
    );
  }
}
