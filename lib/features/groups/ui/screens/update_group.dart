import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:millima/data/models/group/group_model.dart';
import 'package:millima/features/groups/bloc/group_bloc.dart';
import 'package:millima/features/groups/bloc/group_event.dart';
import 'package:millima/features/user/ui/screens/admin_screen.dart';

class UpdateGroup extends StatefulWidget {
  final GroupModel group;
  const UpdateGroup({super.key, required this.group});

  @override
  State<UpdateGroup> createState() => _UpdateGroupState();
}

class _UpdateGroupState extends State<UpdateGroup> {
  TextEditingController nameEditingController = TextEditingController();
  TextEditingController mainTeacherIdController = TextEditingController();
  TextEditingController asistantTeacherIdController = TextEditingController();
  @override
  void initState() {
    super.initState();
    nameEditingController.text = widget.group.name;
    mainTeacherIdController.text = widget.group.main_teacher_id.toString();
    asistantTeacherIdController.text =
        widget.group.assistant_teacher_id.toString();
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
            TextField(
              keyboardType: TextInputType.number,
              controller: mainTeacherIdController,
              decoration: InputDecoration(
                  labelText: "Main Teacher Id",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25))),
            ),
            const SizedBox(height: 15),
            TextField(
              keyboardType: TextInputType.number,
              controller: asistantTeacherIdController,
              decoration: InputDecoration(
                  labelText: "Asistant Teacher Id",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25))),
            ),
            const SizedBox(height: 15),
            ElevatedButton(
                onPressed: () {
                  context.read<GroupBloc>().add(UpdateGroupEvent(
                      groupId: widget.group.id,
                      name: nameEditingController.text,
                      main_teacher_id: int.parse(mainTeacherIdController.text),
                      assistant_teacher_id:
                          int.parse(asistantTeacherIdController.text)));
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
