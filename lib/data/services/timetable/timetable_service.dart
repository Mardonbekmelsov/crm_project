import 'package:millima/utils/network/dio_client.dart';

class TimetableService {
  final dio = DioClient.dio;

  Future<void> createTimetable(
    int group_id,
    int room_id,
    int day_id,
    String start_time,
    String end_time,
  ) async {
    try {
      dio.options.headers['Content-Type'] = 'application/json';

      final data = {
        "group_id": group_id,
        "room_id": room_id,
        "day_id": day_id,
        "start_time": start_time,
        "end_time": end_time
      };

      final response = await dio.post(
        'http://millima.flutterwithakmaljon.uz/api/group-classes',
        data: data,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        print('Timetable created successfully');
      } else {
        print('Failed to add Timetable: ${response.statusCode}');
        throw 'Failed to add Timetable: ${response.statusCode}';
      }
    } catch (e) {
      print('Error adding room: $e');
    }
  }

  Future<Map<String, dynamic>> getGroupTimeTables(int group_id) async {
    try {
      final response = await dio.get(
        'http://millima.flutterwithakmaljon.uz/api/group-timetable/$group_id',
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
}
