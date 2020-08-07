import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_quanly_nhanvien/bloc/detail_room/detail_room_event.dart';
import 'package:flutter_quanly_nhanvien/bloc/detail_room/detail_room_state.dart';
import 'package:flutter_quanly_nhanvien/models/models.dart';
import 'package:rxdart/rxdart.dart';

class DetailRoomBloc extends Bloc<DetailRoomEvent, DetailRoomState> {
  final List<Officer> officers = [];
  final _mnv = BehaviorSubject<String>();
  final _tnv = BehaviorSubject<String>();

  disPose() {
    _tnv.close();
    _mnv.close();
  }

  Stream<String> get mnvStream => _mnv.stream;

  Stream<String> get tnvStream => _tnv.stream;

  Function(String) get changeMnv => _mnv.sink.add;

  Function(String) get changeTnv => _tnv.sink.add;

  Stream<bool> get validAddOfficerInput => Rx.combineLatest2(mnvStream,
      tnvStream, (c, d) => c.toString().isNotEmpty && d.toString().isNotEmpty);

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
      await Future.delayed(Duration(seconds: 2));
      officers.removeAt(event.index);
      print('aaaaaaaaaaa ${officers.length}');
      yield DetailRoomLoadSuccessState(officers: officers);
    }
  }
}
