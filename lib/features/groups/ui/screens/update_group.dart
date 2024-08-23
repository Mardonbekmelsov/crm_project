import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:millima/data/models/group/group_model.dart';
import 'package:millima/features/groups/bloc/group_bloc.dart';
import 'package:millima/features/groups/bloc/group_event.dart';
import 'package:millima/features/user/ui/screens/admin_screen.dart';
import 'package:millima/features/user/ui/widgets/teacher_drop_down.dart';

class UpdateGroup extends StatefulWidget {
  final GroupModel group;
  const UpdateGroup({super.key, required this.group});

  @override
  State<UpdateGroup> createState() => _UpdateGroupState();
}

class _UpdateGroupState extends State<UpdateGroup> {
  TextEditingController nameEditingController = TextEditingController();

  TeacherDropDown? mainTeacher;
  TeacherDropDown? assistantTeacher;

  @override
  void initState() {
    super.initState();
    // Initialize controllers with current group values
    nameEditingController.text = widget.group.name;

    // Initialize dropdowns with current teacher IDs
    mainTeacher = TeacherDropDown(
      label: "Select Main Teacher",
      selectedId: widget.group.main_teacher_id,
    );
    assistantTeacher = TeacherDropDown(
      label: "Select Assistant Teacher",
      selectedId: widget.group.assistant_teacher_id,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Edit Group",
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            const SizedBox(height: 15),
            TextField(
              controller: nameEditingController,
              decoration: InputDecoration(
                  labelText: "Name",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25))),
            ),
            const SizedBox(height: 15),
            mainTeacher!,
            const SizedBox(height: 15),
            assistantTeacher!,
            const SizedBox(height: 15),
            ElevatedButton(
                onPressed: () {
                  // Handle the update group event
                  context.read<GroupBloc>().add(UpdateGroupEvent(
                      groupId: widget.group.id,
                      name: nameEditingController.text,
                      main_teacher_id: mainTeacher!.selectedId!,
                      assistant_teacher_id: assistantTeacher!.selectedId!));
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const AdminScreen(),
                      ));
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    padding: const EdgeInsets.fromLTRB(30, 10, 30, 10)),
                child: const Text(
                  "Update Group",
                  style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w600,
                      color: Colors.white),
                ))
          ],
        ),
      ),
    );
  }
}
