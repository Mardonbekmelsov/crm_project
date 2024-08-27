import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:millima/data/models/timetable/timetable_model.dart';
import 'package:millima/data/services/timetable/timetable_service.dart';
import 'package:millima/features/timetable/bloc/timetable_event.dart';
import 'package:millima/features/timetable/bloc/timetable_state.dart';

class TimetableBloc extends Bloc<TimeTableEvent, TimeTableState> {
  TimetableBloc() : super(TimeTableInitialState()) {
    on<GetTimeTablesEvent>(_onGetTables);
    on<CreateTimeTableEvent>(_addTable);
  }

  Future<void> _onGetTables(GetTimeTablesEvent event, emit) async {
    emit(TimeTableLoadingState());
    final TimetableService timetableService = TimetableService();
    try {
      final Map<String, dynamic> response =
          await timetableService.getGroupTimeTables(event.group_id);

      print(response['data']);

      if (response['data'].isEmpty) {
        emit(TimeTableLoadedState(timeTables: null));
      } else {
        Timetable timeTable = Timetable.fromMap(response['data']);
        emit(TimeTableLoadedState(timeTables: timeTable));
      }
      print(response['data']);
    } catch (e) {
      emit(TimeTableErrorState(error: e.toString()));
    }
  }

  Future<void> _addTable(CreateTimeTableEvent event, emit) async {
    final TimetableService timetableService = TimetableService();
    try {
      await timetableService.createTimetable(event.group_id, event.room_id,
          event.day_id, event.start_time, event.end_time);
    } catch (e) {
      emit(TimeTableErrorState(error: e.toString()));
    }
  }
}
