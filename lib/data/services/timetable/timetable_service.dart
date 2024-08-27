// ignore_for_file: avoid_print

import 'package:millima/utils/network/dio_client.dart';

class TimetableService {
  final dio = DioClient.dio;

  Future<void> createTimetable(
    int groupId,
    int roomId,
    int dayId,
    String startTime,
    String endTime,
  ) async {
    try {
      final data = {
        "group_id": groupId,
        "room_id": roomId,
        "day_id": dayId,
        "start_time": startTime,
        "end_time": endTime
      };

      print("adding room: $data");

      final response = await dio.post(
        'http://millima.flutterwithakmaljon.uz/api/group-classes',
        data: data,
      );

      print("adding result: ${response.data} -------");

      if (response.statusCode == 200 || response.statusCode == 201) {
        print('Timetable created successfully');
      } else {
        print("response code error");
        throw 'Failed to add Timetable: ${response.statusCode}';
      }
    } catch (e) {
      print("catched error");
    }
  }

  Future<Map<String, dynamic>> getGroupTimeTables(int groupId) async {
    try {
      final response = await dio.get(
        'http://millima.flutterwithakmaljon.uz/api/group-timetable/$groupId',
      );

      print("group timetables: ${response.data}");

      if (response.data['success'] == false) {
        throw response.data;
      }
      return response.data;
    } catch (e) {
      print('Error getting timetables: $e');
      rethrow;
    }
  }
}
