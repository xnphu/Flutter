import 'package:equatable/equatable.dart';

class Officer extends Equatable {
  final String id;
  final String name;
  final String roomId;
  final String gender;

  Officer({this.id, this.name, this.roomId, this.gender});
  @override
  // TODO: implement props
  List<Object> get props => [id, name, roomId, gender];
}