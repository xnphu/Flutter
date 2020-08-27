import 'package:flutter_mobile_base_structure/domain/model/officer.dart';
import 'package:flutter_mobile_base_structure/domain/model/room.dart';
import 'package:flutter_mobile_base_structure/domain/repository/room_repository.dart';

class RoomRepositoryImpl implements RoomRepository {
  final List<Room> rooms = [];

  static RoomRepositoryImpl _instance;

  RoomRepositoryImpl getInstance() {
    if (_instance == null) {
      _instance = RoomRepositoryImpl();
    }
    return _instance;
  }

  @override
  Future<List<Room>> getAllRooms() async {
    return rooms;
  }

  @override
  Future<Room> getRoomByIndex({int index}) async {
    return rooms[index];
  }

  @override
  Future<List<Room>> addRoom({Room room}) async {
    rooms.add(room);
    return rooms;
  }

  @override
  Future<List<Room>> deleteRoomByIndex({int index}) async {
    rooms.removeAt(index);
    return rooms;
  }

  @override
  Future<List<Room>> addOfficerToRoom({int roomIndex, Officer officer}) async {
    Room room = rooms[roomIndex];
    List<Officer> list = room.officerList;
    if (list == null) {
      list = [];
    }
    list.add(officer);
    //clone ra 1 room khac
    Room r = rooms[roomIndex].copyWith(officerList: list);
    rooms[roomIndex] = r;
    return rooms;
  }

  @override
  Future<Room> deleteOfficerFromRoom({int roomIndex, int index}) async {
    Room room = rooms[roomIndex];
    List<Officer> list = room.officerList;
    list.removeAt(index);
    Room r = rooms[roomIndex].copyWith(officerList: list);
    rooms[roomIndex] = r;
    return room;
  }

  @override
  Future<Room> editOfficerFromRoom(
      {int roomIndex, int index, String name, String gender}) async {
    Room room = rooms[roomIndex];
    List<Officer> officerList = room.officerList;
    Officer officer = officerList[index].copyWith(name: name, gender: gender);
    officerList[index] = officer;
    Room r = rooms[roomIndex].copyWith(officerList: officerList);
    rooms[roomIndex] = r;
    return room;
  }
}
