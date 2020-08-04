import 'package:equatable/equatable.dart';

class Officer extends Equatable {
  final String id;
  final String name;
  final String roomId;

  Officer({this.id, this.name, this.roomId});
  @override
  // TODO: implement props
  List<Object> get props => [id, name, roomId];
}