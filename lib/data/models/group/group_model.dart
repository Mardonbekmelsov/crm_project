class GroupModel {
  int id;
  String name;
  int main_teacher_id;
  int assistant_teacher_id;
  List students;

  GroupModel({
    required this.id,
    required this.name,
    required this.main_teacher_id,
    required this.assistant_teacher_id,
    required this.students,
  });

  factory GroupModel.fromJson(Map<String, dynamic> json) {
    return GroupModel(
        id: json['id'],
        name: json['name'],
        main_teacher_id: json['main_teacher_id'],
        assistant_teacher_id: json['assistant_teacher_id'],
        students: json['students']);
  }
}
