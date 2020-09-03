import 'package:flutter_mobile_base_structure/domain/model/index.dart';
import 'package:flutter_mobile_base_structure/domain/repository/room_repository.dart';
import 'package:flutter_mobile_base_structure/presentation/base/base_bloc.dart';
import 'package:flutter_mobile_base_structure/presentation/base/base_page_mixin.dart';
import 'package:flutter_mobile_base_structure/presentation/scenes/change_room/change_room_event.dart';
import 'package:flutter_mobile_base_structure/presentation/scenes/detail_room/detail_room_state.dart';
import 'package:flutter_mobile_base_structure/presentation/scenes/home/home_state.dart';

import 'change_room_state.dart';

class ChangeRoomBloc extends BaseBloc<BaseEvent, BaseState> with Validators {
  String roomChoice;
  RoomRepository roomRepository;

  ChangeRoomBloc(this.roomRepository);

  @override
  void dispose() {
    // TODO: implement dispose
  }

  @override
  // TODO: implement initialState
  BaseState get initialState => IdlState();

  @override
  Stream<BaseState> mapEventToState(BaseEvent event) async* {
    if (event is ChangeRoomInitialEvent) {
      List<Room> rooms = await roomRepository.getAllRooms();
      yield ChangeRoomLoadSuccessState(rooms: rooms);
    }

    if (event is SetRoomChoiceInitialEvent) {
      List<Room> rooms = await roomRepository.getAllRooms();
      for (int index = 0; index < rooms.length; index++) {
        List<Officer> _officerList = rooms[index].officerList;
        if (_officerList != null &&
            _officerList.toList().contains(event.officer)) {
          roomChoice = rooms[index].id;
        }
      }
      yield ChangeRoomLoadSuccessState(rooms: rooms, roomChoice: roomChoice);
    }
    if (event is SetRoomChoiceEvent) {
//      print('---------');
//      print('choice ${event.roomChoice}');
//      print('officer ${event.officer}');
      List<Room> rooms = await roomRepository.changeOfficerToRoom(
          roomChoice: event.roomChoice, officer: event.officer);
      yield ChangeRoomLoadSuccessState(
          rooms: rooms, roomChoice: event.roomChoice);
    }
  }
}
