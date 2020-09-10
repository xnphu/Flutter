import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_mobile_base_structure/domain/model/index.dart';
import 'package:flutter_mobile_base_structure/domain/repository/authen_repository.dart';
import 'package:flutter_mobile_base_structure/domain/repository/room_repository.dart';
import 'package:flutter_mobile_base_structure/presentation/base/base_bloc.dart';

import 'home_event.dart';
import 'home_state.dart';

class HomeBloc extends BaseBloc<BaseEvent, BaseState> with Validators {
  RoomRepository roomRepository;
  AuthenticationRepository authenticationRepository;
  String roomChoice = '';
  final _mpb = BehaviorSubject<String>();
  final _tpb = BehaviorSubject<String>();
  final _mnv = BehaviorSubject<String>();
  final _tnv = BehaviorSubject<String>();

  Stream<String> get mpbStream => _mpb.stream;

  Stream<String> get tpbStream => _tpb.stream;

  Stream<String> get mnvStream => _mnv.stream;

  Stream<String> get tnvStream => _tnv.stream;

  Function(String) get changeMpb => _mpb.sink.add;

  Function(String) get changeTpb => _tpb.sink.add;

  Function(String) get changeMnv => _mnv.sink.add;

  Function(String) get changeTnv => _tnv.sink.add;

  Stream<bool> get validInput => Rx.combineLatest2(
      mpbStream,
      tpbStream,
      (a, b) =>
          a.toString().trim().isNotEmpty && b.toString().trim().isNotEmpty);

  Stream<bool> get validAddOfficerInput => Rx.combineLatest2(mnvStream,
      tnvStream, (c, d) => c.toString().isNotEmpty && d.toString().isNotEmpty);

  HomeBloc(this.roomRepository, this.authenticationRepository) : super();

  @override
  void dispose() {
    // TODO: implement dispose
    _mpb.close();
    _tpb.close();
    _tnv.close();
    _mnv.close();
  }

  disposeAddOfficer() {
    _tnv.close();
    _mnv.close();
  }

  @override
  // TODO: implement initialState
  BaseState get initialState => IdlState();

  @override
  Stream<BaseState> mapEventToState(BaseEvent event) async* {
    if (event is HomeInitialEvent) {
      List<Room> rooms = await roomRepository.getAllRooms();
      yield HomeLoadSuccessState(rooms: rooms);
    }
    if (event is AddRoomEvent) {
      yield HomeLoadInProgressState();
      await Future.delayed(Duration(seconds: 2));
      List<Room> rooms = await roomRepository.addRoom(room: event.room);
      yield HomeLoadSuccessState(rooms: rooms);
    }

    if (event is DeleteRoomEvent) {
      yield HomeLoadInProgressState();
      List<Room> rooms =
          await roomRepository.deleteRoomByIndex(index: event.index);
      yield HomeLoadSuccessState(rooms: rooms);
    }

    if (event is AddOfficerToRoomEvent) {
      List<Room> rooms = await roomRepository.addOfficerToRoom(
          roomIndex: event.roomIndex, officer: event.officer);
      yield HomeLoadSuccessState(rooms: rooms);
    }

    if (event is LogOutEvent) {
      await authenticationRepository.logOut();
    }
  }
}
