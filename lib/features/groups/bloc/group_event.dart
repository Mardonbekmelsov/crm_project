import 'package:equatable/equatable.dart';

sealed class GroupEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetGroupsEvent extends GroupEvent {}

class UpdateGroupEvent extends GroupEvent {
  final int groupId;
  final String name;
  final int main_teacher_id;
  final int assistant_teacher_id;

  UpdateGroupEvent({
    required this.groupId,
    required this.name,
    required this.main_teacher_id,
    required this.assistant_teacher_id,
  });
}

class AddGroupEvent extends GroupEvent {
  final String name;
  final int main_teacher_id;
  final int assistant_teacher_id;

  AddGroupEvent({
    required this.name,
    required this.main_teacher_id,
    required this.assistant_teacher_id,
  });
}

class AddStudentsToGroupEvent extends GroupEvent {
  final int groupId;
  final List studentsId;

  AddStudentsToGroupEvent({
    required this.groupId,
    required this.studentsId,
  });
}
