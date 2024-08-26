class WeekDay {
  String room;
  String start_time;
  String end_time;

  WeekDay({
    required this.room,
    required this.start_time,
    required this.end_time,
  });

  factory WeekDay.fromMap(Map<String, dynamic> map) {
    return WeekDay(
      room: map['room'],
      start_time: map['start_time'],
      end_time: map['end_time'],
    );
  }
}