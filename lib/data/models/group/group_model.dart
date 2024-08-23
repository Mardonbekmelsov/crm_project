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
}
