
import 'package:millima/data/models/timetable/week_day.dart';

class Timetable {
  Map<String, List<WeekDay>> week_days;

  Timetable({required this.week_days});

  factory Timetable.fromMap(Map<String, dynamic> map) {
    return Timetable(
      week_days: map.map(
        (key, value) => MapEntry(
          key,
          (value as List<dynamic>).map((e) => WeekDay.fromMap(e)).toList(),
        ),
      ),
    );
  }
}