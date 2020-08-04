import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_quanly_nhanvien/bloc/room/room_event.dart';
import 'package:flutter_quanly_nhanvien/bloc/room/room_state.dart';
import 'package:flutter_quanly_nhanvien/models/models.dart';
import 'package:rxdart/rxdart.dart';

class RoomBloc extends Bloc<RoomEvent, RoomState> {
  final List<Room> rooms = [];
  final _mpb = BehaviorSubject<String>();
  final _tpb = BehaviorSubject<String>();
  final _mnv = BehaviorSubject<String>();
  final _tnv = BehaviorSubject<String>();

  disPose(){
    _tnv.close();
    _mnv.close();
  }

  Stream<String> get mpbStream => _mpb.stream;

  Stream<String> get tpbStream => _tpb.stream;

  Stream<String> get mnvStream => _mnv.stream;

  Stream<String> get tnvStream => _tnv.stream;

  Function(String) get changeMpb => _mpb.sink.add;

  Function(String) get changeTpb => _tpb.sink.add;

  Function(String) get changeMnv => _mnv.sink.add;

  Function(String) get changeTnv => _tnv.sink.add;

  Stream<bool> validInput;
  Stream<bool> validAddOfficerInput;

  RoomBloc() : super(RoomInitialState()) {
    validInput = Rx.combineLatest2(mpbStream, tpbStream,
        (a, b) => a.toString().isNotEmpty && b.toString().isNotEmpty);
    validAddOfficerInput = Rx.combineLatest2(mnvStream, tnvStream,
            (a, b) => a.toString().isNotEmpty && b.toString().isNotEmpty);
  }

  @override
  Stream<RoomState> mapEventToState(RoomEvent event) async* {
    // TODO: implement mapEventToState
    if (event is RoomAddedEvent) {
      print('event: $event');
      yield RoomLoadInProgressState();
      await Future.delayed(Duration(seconds: 2));
      rooms.add(event.room);

      yield RoomLoadSuccessState(rooms: rooms);
    }
    if (event is RoomDeletedEvent) {
      print('event: $event');
      yield RoomLoadInProgressState();
      await Future.delayed(Duration(seconds: 2));
      rooms.removeAt(event.index);
      yield RoomLoadSuccessState(rooms: rooms);
    }
    if (event is AddOfficerToRoomEvent) {
      print('event: ${event.roomId}');
      print('event: ${event.maNhanVien}');
      print('event: ${event.tenNhanVien}');
      yield RoomLoadInProgressState();
      await Future.delayed(Duration(seconds: 2));
//      rooms[event.roomId].officerList.add(event.officer);

      yield RoomLoadSuccessState(rooms: rooms);
    }
  }
}
