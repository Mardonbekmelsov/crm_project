// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:millima/features/subject/bloc/subject_bloc.dart';
import 'package:millima/features/subject/bloc/subject_state.dart';
import 'package:millima/features/users/bloc/users_bloc.dart';
import 'package:millima/features/users/bloc/users_event.dart';
import 'package:millima/features/users/bloc/users_state.dart';

class SubjectDropForGroup extends StatefulWidget {
  

  SubjectDropForGroup({super.key, required this.selectedId});

  int? selectedId;
  int get id => selectedId!;

  @override
  State<SubjectDropForGroup> createState() => _SubjectDropForGroupState();
}

class _SubjectDropForGroupState extends State<SubjectDropForGroup> {
  @override
  void initState() {
    super.initState();
    context.read<UsersBloc>().add(GetUsersEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SubjectBloc, SubjectState>(
      buildWhen: (previous, current) => current is UsersLoadedState,
      builder: (context, state) {
        if (state is SubjectsLoadedState) {
          final subjects =
              state.subjects;

          return DropdownButtonFormField<int>(
            value: widget.selectedId,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: "Choose Subject",
            ),
            items: [
              for (var subject in subjects)
                DropdownMenuItem(
                  value: subject.id,
                  child: Text(subject.name),
                ),
            ],
            onChanged: (value) {
              setState(() {
                widget.selectedId = value;
              });
            },
          );
        }
        return const CircularProgressIndicator();
      },
    );
  }
}
