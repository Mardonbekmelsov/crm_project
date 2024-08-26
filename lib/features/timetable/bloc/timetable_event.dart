import 'package:equatable/equatable.dart';

sealed class TimeTableEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetTimeTablesEvent extends TimeTableEvent {
  final int group_id;
  GetTimeTablesEvent({required this.group_id});
}

class CreateTimeTableEvent extends TimeTableEvent {
  final int group_id;
  final int room_id;
  final int day_id;
  final String start_time;
  final String end_time;

  CreateTimeTableEvent({
    required this.group_id,
    required this.room_id,
    required this.day_id,
    required this.start_time,
    required this.end_time,
  });
}