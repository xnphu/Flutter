import 'package:equatable/equatable.dart';

class Officer extends Equatable {
  final String id;
  final String name;
  final String roomId;
  final String gender;
  final Position position;

  Officer copyWith({String id, String name, String gender, String roomId, Position position}) =>
      Officer(
        id: id ?? this.id,
        name: name ?? this.name,
        gender: gender ?? this.gender,
        roomId: roomId ?? this.roomId,
        position: position ?? this.position,
      );

  Officer({this.id, this.name, this.roomId, this.gender, this.position=Position.NhanVien});

  @override
  // TODO: implement props
  List<Object> get props => [id, name, roomId, gender, position];
}

enum Position { TruongPhong, PhoPhong, NhanVien }
