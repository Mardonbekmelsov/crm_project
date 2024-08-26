
import 'package:millima/utils/network/dio_client.dart';

class RoomService {
  final dio = DioClient.dio;

  Future<void> addRoom(
      String name, String description, int capacity) async {
    try {
  

      final data = {
        "name": name,
        "description": description,
        "capacity": capacity,
      };

      final response = await dio.post(
        'http://millima.flutterwithakmaljon.uz/api/rooms',
        data: data,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        print('Room added successfully');
      } else {
        print('Failed to add room: ${response.statusCode}');
        throw 'Failed to add room: ${response.statusCode}';
      }
    } catch (e) {
      print('Error adding room: $e');
    }
  }

  Future<Map<String, dynamic>> getRooms() async {
    try {
      final response = await dio.get(
        'http://millima.flutterwithakmaljon.uz/api/rooms',
      );

      if (response.data['success'] == false) {
        throw response.data;
      }
      return response.data;
    } catch (e) {
      print('Error getting rooms: $e');
      throw e;
    }
  }
  Future<Map<String, dynamic>> getAvailableRooms(
    int day_id,
    String start_time,
    String end_time,
  ) async {
    try {
      final response = await dio.get(
        'http://millima.flutterwithakmaljon.uz/api/available-rooms?day_id=$day_id&start_time=$start_time&end_time=$end_time',
      );

      if (response.data['success'] == false) {
        throw response.data;
      }
      return response.data;
    } catch (e) {
      print('Error getting room: $e');
      throw e;
    }
  }

  Future<void> updateRoom(int roomId,
      String name, String description, int capacity) async {
    try {
      final response = await dio.put(
        'http://millima.flutterwithakmaljon.uz/api/rooms/$roomId',
        data: {
          'name': name,
          'description': description,
          'capacity': capacity,
        },
      );

      if (response.statusCode == 200) {
        print('Room updated successfully');
      } else {
        print('Failed to update room: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }
  Future<void> deleteRoom(int roomId) async {
    try {
      final response = await dio.delete(
        'http://millima.flutterwithakmaljon.uz/api/rooms/$roomId',
      );

      if (response.statusCode == 200) {
        print('Room deleted successfully');
      } else {
        print('Failed to delete room: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  
}