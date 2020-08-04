import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_quanly_nhanvien/bloc/officer/officer_event.dart';
import 'package:flutter_quanly_nhanvien/bloc/officer/officer_state.dart';
import 'package:flutter_quanly_nhanvien/models/models.dart';
import 'package:rxdart/rxdart.dart';

class OfficerBloc extends Bloc<OfficerEvent, OfficerState> {
  final List<Officer> officers = [];
  final _mnv = BehaviorSubject<String>();
  final _tnv = BehaviorSubject<String>();

  Stream<String> get mnvStream => _mnv.stream;

  Stream<String> get tnvStream => _tnv.stream;

  Function(String) get changeMnv => _mnv.sink.add;

  Function(String) get changeTnv => _tnv.sink.add;

  Stream<bool> get validInput => Rx.combineLatest2(mnvStream, tnvStream,
      (a, b) => a.toString().isNotEmpty && b.toString().isNotEmpty);

  OfficerBloc() : super(OfficerInitialState());

  @override
  Stream<OfficerState> mapEventToState(OfficerEvent event) async* {
    // TODO: implement mapEventToState
    if (event is OfficerAddedEvent) {
      print('event: $event');
      yield OfficerLoadInProgressState();
      await Future.delayed(Duration(seconds: 2));
      officers.add(event.officer);
      yield OfficerLoadSuccessState(officers: officers);
    }
    if (event is OfficerDeletedEvent) {
      print('event: $event');
      yield OfficerLoadInProgressState();
      await Future.delayed(Duration(seconds: 2));
      officers.removeAt(event.index);
      yield OfficerLoadSuccessState(officers: officers);
    }
  }
}
