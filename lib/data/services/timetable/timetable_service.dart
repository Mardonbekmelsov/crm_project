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

      final data = {
        "group_id": group_id,
        "room_id": room_id,
        "day_id": day_id,
        "start_time": start_time,
        "end_time": end_time
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

  Future<Map<String, dynamic>> getGroupTimeTables(int group_id) async {
    try {
      final response = await dio.get(
        'http://millima.flutterwithakmaljon.uz/api/group-timetable/$group_id',
      );

      print("group timetables: ${response.data}");

      if (response.data['success'] == false) {
        throw response.data;
      }
      return response.data;
    } catch (e) {
      print('Error getting timetables: $e');
      throw e;
    }
  }
}
