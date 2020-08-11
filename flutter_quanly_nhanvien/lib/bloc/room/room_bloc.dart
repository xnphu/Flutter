import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_quanly_nhanvien/bloc/room/room_event.dart';
import 'package:flutter_quanly_nhanvien/bloc/room/room_state.dart';
import 'package:flutter_quanly_nhanvien/models/models.dart';
import 'package:rxdart/rxdart.dart';

class RoomBloc extends Bloc<RoomEvent, RoomState> {
  final List<Room> rooms = [];
  String roomChoice = '';
  final _mpb = BehaviorSubject<String>();
  final _tpb = BehaviorSubject<String>();
  final _mnv = BehaviorSubject<String>();
  final _tnv = BehaviorSubject<String>();

  disPose() {
    _mpb.close();
    _tpb.close();
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

  Stream<bool> get validInput => Rx.combineLatest2(mpbStream, tpbStream,
      (a, b) => a.toString().isNotEmpty && b.toString().isNotEmpty);

  Stream<bool> get validAddOfficerInput => Rx.combineLatest2(mnvStream,
      tnvStream, (c, d) => c.toString().isNotEmpty && d.toString().isNotEmpty);

  RoomBloc() : super(RoomInitialState());

  @override
  Stream<RoomState> mapEventToState(RoomEvent event) async* {
    // TODO: implement mapEventToState
    if (event is RoomAddedEvent) {
      print('event: $event');
      yield RoomLoadInProgressState();
      await Future.delayed(Duration(seconds: 2));
      rooms.add(event.room);

      yield RoomLoadSuccessState(rooms: rooms);
      print('nnnnnn $rooms');
    }
    if (event is RoomDeletedEvent) {
      print('event: $event');
      yield RoomLoadInProgressState();
      await Future.delayed(Duration(seconds: 2));
      rooms.removeAt(event.index);
      yield RoomLoadSuccessState(rooms: rooms);
    }
    if (event is AddOfficerToRoomEvent) {
      print('event: $event');
//      yield RoomLoadInProgressState();
//      await Future.delayed(Duration(seconds: 2));
      Room room = rooms[event.roomIndex];

      List<Officer> list = room.officerList;
      if (list == null) {
        list = [];
      }
      list.add(event.officer);
      //clone ra 1 room khac
      Room r = rooms[event.roomIndex].copyWith(officerList: list);
      rooms[event.roomIndex] = r;

      yield RoomLoadSuccessState(rooms: rooms);
    }

    if (event is RoomModifyEvent) {
//      yield RoomLoadInProgressState();
//      await Future.delayed(Duration(seconds: 2));
      Room r =
          rooms[event.roomIndex].copyWith(officerList: event.officerNewList);
      rooms[event.roomIndex] = r;
      yield RoomLoadSuccessState(rooms: rooms);
    }

    if (event is ChangeRoomEvent) {
      print('aaaaaaaaa ${event.abc}');
    }

    if (event is SetRoomChoiceInitialValueEvent) {
      print('---------');
      print('choice ${event.roomChoice}');
      print('officer ${event.officer}');
      rooms.forEach((room) {
        Officer _officer = event.officer;
        List<Officer> _officerList = room.officerList;
        String _roomId = event.roomChoice;
        if (_officerList!=null&& _officerList.contains(_officer)) {
          _officerList.remove(_officer);
        }
        if (room.id == _roomId) {
          print('eeeeeeeee $_officer');
          if (_officerList == null) {
            _officerList = [];
          }
          _officerList.add(_officer);
          print('list add $_officerList');
        }
      });
      yield RoomChoiceLoadSuccessState(roomChoice: event.roomChoice);
    }

    if (event is SetRoomChoiceEvent) {
      for (int index = 0; index < rooms.length; index++) {
        List<Officer> _officerList = rooms[index].officerList;
        if (_officerList != null &&
            _officerList.toList().contains(event.officer)) {
          roomChoice = rooms[index].id;
        }
      }
    yield RoomChoiceLoadSuccessState(roomChoice: roomChoice);
    }
  }
}
