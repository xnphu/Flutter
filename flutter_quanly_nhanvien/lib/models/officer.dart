import 'package:equatable/equatable.dart';

class Officer extends Equatable {
  final String id;
  final String name;
  final String roomId;
  final String gender;
  final String position;

  Officer copyWith({String id, String name, String gender, String roomId, String position}) =>
      Officer(
        id: id ?? this.id,
        name: name ?? this.name,
        gender: gender ?? this.gender,
        roomId: roomId ?? this.roomId,
      );

  Officer({this.id, this.name, this.roomId, this.gender, this.position});

  @override
  // TODO: implement props
  List<Object> get props => [id, name, roomId, gender, position];
}
