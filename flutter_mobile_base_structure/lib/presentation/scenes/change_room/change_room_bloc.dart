import 'package:flutter_mobile_base_structure/domain/model/index.dart';
import 'package:flutter_mobile_base_structure/domain/repository/room_repository.dart';
import 'package:flutter_mobile_base_structure/presentation/base/base_bloc.dart';
import 'package:flutter_mobile_base_structure/presentation/base/base_page_mixin.dart';
import 'package:flutter_mobile_base_structure/presentation/scenes/change_room/change_room_event.dart';

import 'change_room_state.dart';

class ChangeRoomBloc extends BaseBloc<BaseEvent, BaseState> with Validators {
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
      print('room $rooms');
      yield ChangeRoomLoadSuccessState(rooms: rooms);
    }
  }
}
