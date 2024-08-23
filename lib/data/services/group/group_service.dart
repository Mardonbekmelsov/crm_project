import 'package:millima/utils/network/dio_client.dart';

class GroupService {
  final dio = DioClient.dio;

  Future<void> addGroup(
      String name, int mainTeacherId, int assistantTeacherId) async {
    try {

      final data = {
        "name": name,
        "main_teacher_id": mainTeacherId,
        "assistant_teacher_id": assistantTeacherId,
      };

      final response = await dio.post(
        '/groups',
        data: data,
      );

      print(response);

      if (response.statusCode == 200 || response.statusCode == 201) {
        print('Group added successfully');
      } else {
        throw 'Failed to add group: ${response.statusCode}';
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<Map<String, dynamic>> getGroups() async {
    try {
      final response = await dio.get(
        '/groups',
      );

      if (response.data['success'] == false) {
        throw response.data;
      }
      return response.data;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> updateGroup(int groupId, String name, int mainTeacherId,
      int assistantTeacherId) async {
    try {
      final response = await dio.put(
        '/groups/$groupId',
        data: {
          'name': name,
          'main_teacher_id': mainTeacherId,
          'assistant_teacher_id': assistantTeacherId,
        },
      );

      if (response.statusCode == 200) {
        print('Group updated successfully');
      } else {
        print('Failed to update group: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
      rethrow;
    }
  }

  Future<void> addStudentsToGroup(int groupId, List studentIds) async {
    try {
      final response = await dio.post(
        '/groups/$groupId/students',
        data: {
          'students': studentIds,
        },
      );

      if (response.statusCode == 200) {
        print('Students added successfully');
      } else {
        print('Failed to add students: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }
}
