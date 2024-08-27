import 'package:millima/data/models/class/class_model.dart';
import 'package:millima/data/models/subject/subject_model.dart';

class GroupModel {
  int id;
  String name;
  int mainTeacherId;
  int assistantTeacherId;
  List students;
  SubjectModel? subject;
  List<ClassModel> classes;

  GroupModel({
    required this.id,
    required this.name,
    required this.mainTeacherId,
    required this.assistantTeacherId,
    required this.students,
    required this.subject,
    required this.classes,
  });

  factory GroupModel.fromJson(Map<String, dynamic> json) {
    return GroupModel(
      id: json['id'],
      name: json['name'],
      mainTeacherId: json['main_teacher_id'],
      assistantTeacherId: json['assistant_teacher_id'],
      students: json['students'],
      subject: json['subject'] == null
          ? null
          : SubjectModel.fromJson(json['subject']),
      classes: json['classes'] == null
          ? []
          : (json['classes'] as List).map((clas) {
              return ClassModel.fromjson(clas);
            }).toList(),
    );
  }
}
