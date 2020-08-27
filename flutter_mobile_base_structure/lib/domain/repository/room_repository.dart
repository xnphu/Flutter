import 'package:flutter_mobile_base_structure/domain/model/index.dart';
import 'package:flutter_mobile_base_structure/domain/model/room.dart';

abstract class RoomRepository {
  Future<List<Room>> getAllRooms();
  Future<Room> getRoomByIndex({int index});
  Future<List<Room>> addRoom({Room room});
  Future<List<Room>> deleteRoomByIndex({int index});
  Future<List<Room>> addOfficerToRoom({int roomIndex, Officer officer});
  Future<Room> deleteOfficerFromRoom({int roomIndex, int index});
  Future<Room> editOfficerFromRoom({int roomIndex, int index, String name, String gender});
}
