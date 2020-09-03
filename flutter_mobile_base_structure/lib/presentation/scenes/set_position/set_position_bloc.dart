import 'package:flutter_mobile_base_structure/domain/model/index.dart';
import 'package:flutter_mobile_base_structure/domain/repository/room_repository.dart';
import 'package:flutter_mobile_base_structure/presentation/base/base_bloc.dart';
import 'package:flutter_mobile_base_structure/presentation/scenes/set_position/index.dart';

class SetPositionBloc extends BaseBloc<BaseEvent, BaseState> with Validators {
  RoomRepository roomRepository;

  SetPositionBloc(this.roomRepository);

  @override
  void dispose() {
    // TODO: implement dispose
  }

  @override
  // TODO: implement initialState
  BaseState get initialState => IdlState();

  @override
  Stream<BaseState> mapEventToState(BaseEvent event) async* {
    if (event is SetPositionInitialEvent) {
      Room room = await roomRepository.getRoomByIndex(index: event.roomIndex);
      List<Officer> officers = room.officerList;
      yield SetPositionLoadSuccessState(officers: officers);
    }

    if (event is SetTruongPhongEvent) {
      Room room = await roomRepository.setTruongPhong(
          roomIndex: event.roomIndex, officerIndex: event.officerIndex);
      List<Officer> officers = room.officerList;
      yield SetPositionLoadSuccessState(officers: officers);
    }

    if (event is SetPhoPhongEvent) {
      Room room = await roomRepository.setPhoPhong(
          roomIndex: event.roomIndex,
          officerIndex: event.officerIndex,
          isSelected: event.isSelected);
      List<Officer> officers = room.officerList;
      yield SetPositionLoadSuccessState(officers: officers);
    }
  }
}
