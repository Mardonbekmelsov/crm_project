import 'package:flutter/material.dart';
import 'package:millima/data/models/group/group_model.dart';
import 'package:millima/features/timetable/bloc/timetable_bloc.dart';
import 'package:millima/features/timetable/bloc/timetable_event.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:millima/features/timetable/bloc/timetable_state.dart';

class GroupWidget extends StatelessWidget {
  final GroupModel group;

  const GroupWidget({super.key, required this.group});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.blue.shade700,
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            offset: Offset(0, 4),
            blurRadius: 10,
          ),
        ],
      ),
      padding: const EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.group, color: Colors.white, size: 28),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  "Group Name: ${group.name}",
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          const Divider(color: Colors.white38, thickness: 1, height: 20),
          Row(
            children: [
              const Icon(Icons.person, color: Colors.white, size: 24),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  "Main Teacher ID: ${group.main_teacher_id}",
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: Colors.white70,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              const Icon(Icons.person_outline, color: Colors.white, size: 24),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  "Assistant Teacher ID: ${group.assistant_teacher_id}",
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: Colors.white70,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          BlocProvider(
            create: (context) =>
                TimetableBloc()..add(GetTimeTablesEvent(group_id: group.id)),
            child: BlocBuilder<TimetableBloc, TimeTableState>(
              builder: (context, state) {
                return ExpansionTile(
                  title: const Text(
                    "View Timetables",
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  iconColor: Colors.white,
                  collapsedIconColor: Colors.white,
                  children: [
                    if (state is TimeTableLoadingState)
                      const Padding(
                        padding: EdgeInsets.all(16.0),
                        child: CircularProgressIndicator(
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.white),
                        ),
                      ),
                    if (state is TimeTableLoadedState)
                      _buildTimetablesList(state),
                    if (state is TimeTableErrorState)
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(
                          "Error: ${state.error}",
                          style: const TextStyle(color: Colors.red),
                        ),
                      ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTimetablesList(TimeTableLoadedState state) {
    if (state.timeTables == null) {
      return Text("There are no available timetables yet");
    }
    return Column(
      children: state.timeTables!.week_days.entries.map((entry) {
        return ListTile(
          title: Text(
            entry.key,
            style: const TextStyle(color: Colors.white),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: entry.value.map((session) {
              return Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Row(
                  children: [
                    Text(
                      "${session.start_time} - ${session.end_time}",
                      style: const TextStyle(color: Colors.white70),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      "Room: ${session.room}",
                      style: const TextStyle(color: Colors.white70),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        );
      }).toList(),
    );
  }
}
