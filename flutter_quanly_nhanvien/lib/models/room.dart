import 'package:equatable/equatable.dart';
import 'package:flutter_quanly_nhanvien/models/officer.dart';

class Room extends Equatable {
  final String id;
  final String name;
  final List<Officer> officerList;

  Room copyWith({String id, String name, List<Officer> officerList}) => Room(
      id: id ?? this.id,
      name: name ?? this.name,
      officerList: officerList ?? this.officerList);

  Room({this.id, this.name, this.officerList});

  Room.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        officerList = json['officerList'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'officerList': officerList,
      };

  @override
  // TODO: implement props
  List<Object> get props => [id, name, officerList];
}
