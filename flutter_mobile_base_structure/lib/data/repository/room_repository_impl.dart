import 'package:flutter_mobile_base_structure/domain/model/officer.dart';
import 'package:flutter_mobile_base_structure/domain/model/room.dart';
import 'package:flutter_mobile_base_structure/domain/repository/room_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RoomRepositoryImpl implements RoomRepository {
  final List<Room> rooms = [];
  CollectionReference roomsCollection = Firestore.instance.collection('rooms');

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
    roomsCollection
        .add(
            {'id': room.id, 'name': room.name, 'officerList': room.officerList})
        .then((value) => print('room added'))
        .catchError((err) => print('err $err'));
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

  @override
  Future<List<Room>> changeOfficerToRoom(
      {String roomChoice, Officer officer}) async {
    //chuyen list null -> []
    rooms.asMap().forEach((index, room) {
      if (room.officerList == null) {
        Room r = room.copyWith(officerList: []);
        rooms[index] = r;
      }
    });
    rooms.asMap().forEach((index, room) {
      Officer _officer = officer;
      List<Officer> _officerList = room.officerList;
      String _roomId = roomChoice;
      if (_officerList == null) {
        _officerList = [];
      }
      if (_officerList != null && _officerList.contains(_officer)) {
        _officerList.remove(_officer);
//          print('list $index remove  $_officerList');
      }
      if (room.id == _roomId) {
        _officerList.add(_officer);
//          print('list $index add ${_officerList}');
      }
//        print('list $index final ${_officerList}');
    });
//    print('rooms ${rooms[0].officerList}');
    return rooms;
  }

  @override
  Future<Room> setTruongPhong({int roomIndex, int officerIndex}) async {
    List<Officer> _officerList = rooms[roomIndex].officerList;
    //chuyen truong phong truoc ve nhan vien
    _officerList.asMap().forEach((index, officer) {
      if (officer.position == Position.TruongPhong) {
        Officer temp = officer.copyWith(position: Position.NhanVien);
        _officerList[index] = temp;
      }
    });
    //chuyen truong phong moi
    Officer officerTemp =
        _officerList[officerIndex].copyWith(position: Position.TruongPhong);
    _officerList[officerIndex] = officerTemp;
    return rooms[roomIndex];
  }

  @override
  Future<Room> setPhoPhong(
      {int roomIndex, int officerIndex, bool isSelected}) async {
    List<Officer> _officerList = rooms[roomIndex].officerList;
    if (isSelected == true) {
      print('position ${_officerList[officerIndex].position}');
      Officer officerTemp =
          _officerList[officerIndex].copyWith(position: Position.PhoPhong);
      _officerList[officerIndex] = officerTemp;
    } else {
      Officer officerTemp =
          _officerList[officerIndex].copyWith(position: Position.NhanVien);
      _officerList[officerIndex] = officerTemp;
    }
    return rooms[roomIndex];
  }
}
