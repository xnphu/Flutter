import 'package:flutter_mobile_base_structure/domain/model/index.dart';
import 'package:flutter_mobile_base_structure/domain/repository/room_repository.dart';
import 'package:flutter_mobile_base_structure/presentation/base/base_bloc.dart';
import 'package:flutter_mobile_base_structure/presentation/scenes/detail_room/detail_room_event.dart';
import 'package:flutter_mobile_base_structure/presentation/scenes/detail_room/detail_room_state.dart';
import 'package:flutter_mobile_base_structure/presentation/scenes/home/home_state.dart';

class DetailRoomBloc extends BaseBloc<BaseEvent, BaseState> with Validators {
  final List<Officer> officerListLocal = [];
  RoomRepository roomRepository;
  final _tnv = BehaviorSubject<String>();

  Stream<String> get tnvStream => _tnv.stream;

  Function(String) get changeTnv => _tnv.sink.add;

  Stream<bool> get validEditOfficerInput =>
      Rx.combineLatest([tnvStream], (c) => c.toString().trim().isNotEmpty);

  DetailRoomBloc(this.roomRepository);

  @override
  void dispose() {
    // TODO: implement dispose
    _tnv.close();
  }

  @override
  // TODO: implement initialState
  BaseState get initialState => IdlState();

  @override
  Stream<BaseState> mapEventToState(BaseEvent event) async* {
    if (event is DetailRoomInitialEvent) {
      Room room = await roomRepository.getRoomByIndex(index: event.index);
      List<Officer> officerList = room.officerList;
      //set list local state
      officerListLocal.addAll(officerList);
      yield DetailRoomLoadSuccessState(officerList: officerList);
    }

    if (event is DeleteOfficerEvent) {
      Room room = await roomRepository.deleteOfficerFromRoom(
          roomIndex: event.roomIndex, index: event.index);
      List<Officer> officerList = room.officerList;
      yield DetailRoomLoadSuccessState(officerList: officerList);
    }

    if (event is EditOfficerEvent) {
      Room room = await roomRepository.editOfficerFromRoom(
          roomIndex: event.roomIndex,
          index: event.index,
          name: event.name,
          gender: event.gender);
      List<Officer> officerList = room.officerList;
      //set list local state
      officerListLocal.removeRange(0, officerListLocal.length);
      officerListLocal.addAll(officerList);
      yield DetailRoomLoadSuccessState(officerList: officerList);
    }
  }
}
