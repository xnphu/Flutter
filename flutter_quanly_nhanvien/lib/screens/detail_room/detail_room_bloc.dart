import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_quanly_nhanvien/screens/detail_room/detail_room_event.dart';
import 'package:flutter_quanly_nhanvien/screens/detail_room/detail_room_state.dart';
import 'package:flutter_quanly_nhanvien/models/models.dart';
import 'package:rxdart/rxdart.dart';

class DetailRoomBloc extends Bloc<DetailRoomEvent, DetailRoomState> {
  final List<Officer> officers = [];
  final _tnv = BehaviorSubject<String>();

  disPose() {
    _tnv.close();
  }

  Stream<String> get tnvStream => _tnv.stream;

  Function(String) get changeTnv => _tnv.sink.add;

  Stream<bool> get validEditOfficerInput =>
      Rx.combineLatest([tnvStream], (c) => c.toString().isNotEmpty);

  DetailRoomBloc() : super(DetailRoomInitialState());

  @override
  Stream<DetailRoomState> mapEventToState(DetailRoomEvent event) async* {
    // TODO: implement mapEventToState
    if (event is DetailRoomInitialEvent) {
//      yield DetailRoomLoadInProgressState();
      officers.addAll(List.from(event.officers));
      yield DetailRoomLoadSuccessState(officers: officers);
    }
    if (event is DeleteOfficerEvent) {
//      yield DetailRoomLoadInProgressState();
      officers.removeAt(event.index);
      yield RemoveSuccessState(officers: officers);
    }
    if (event is EditOfficerEvent) {
//      yield DetailRoomLoadInProgressState();
      Officer officer = officers[event.index]
          .copyWith(name: event.name, gender: event.gender);
      officers[event.index] = officer;
      yield DetailRoomLoadSuccessState(officers: officers);
    }
    if (event is ChangeRoomSuccessEvent) {
      print('aaaaa ${event.officers}');
      officers.addAll(List.from(event.officers));
      yield ChangeRoomSuccessState(officers: officers);
    }
  }
}
