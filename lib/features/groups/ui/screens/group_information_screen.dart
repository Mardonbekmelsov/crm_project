import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:millima/data/models/group/group_model.dart';
import 'package:millima/data/models/models.dart';
import 'package:millima/features/users/bloc/users_bloc.dart';
import 'package:millima/features/users/bloc/users_event.dart';
import 'package:millima/features/users/bloc/users_state.dart';

class GroupInformationScreen extends StatefulWidget {
  final GroupModel groupModel;
  const GroupInformationScreen({super.key, required this.groupModel});

  @override
  State<GroupInformationScreen> createState() => _GroupInformationScreenState();
}

class _GroupInformationScreenState extends State<GroupInformationScreen> {
  @override
  void initState() {
    super.initState();
    context.read<UsersBloc>().add(GetUsersEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<UsersBloc, UsersState>(builder: (context, state) {
        if (state is UsersLoadingState) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is UsersErrorState) {
          return Center(
            child: Text(state.error),
          );
        }
        if (state is UsersLoadedState) {
          List<UserModel> students = [];
          for (var map in widget.groupModel.students) {
            int mapId = map['id'];
            UserModel? matchedModel = state.users.firstWhere(
              (model) => model.id == mapId,
            );
            students.add(matchedModel);
          }
          UserModel mainTeacher = state.users.firstWhere(
            (element) => element.id == widget.groupModel.mainTeacherId,
          );
          UserModel asistantTeacher = state.users.firstWhere(
            (element) => element.id == widget.groupModel.assistantTeacherId,
          );
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppBar(
                centerTitle: true,
                title: Text(
                  widget.groupModel.name,
                  style: const TextStyle(fontSize: 30, fontWeight: FontWeight.w600),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Teachers",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                    ),
                    ListTile(
                      title: Text(
                        mainTeacher.name,
                        style: const TextStyle(fontSize: 20),
                      ),
                      subtitle: Text(mainTeacher.phone),
                      leading: CircleAvatar(
                        child: Container(
                          decoration: const BoxDecoration(
                              shape: BoxShape.circle, color: Colors.grey),
                          clipBehavior: Clip.hardEdge,
                          child: mainTeacher.photo == null
                              ? const Icon(
                                  Icons.person,
                                  size: 40,
                                )
                              : Image.network(
                                  "http://millima.flutterwithakmaljon.uz/storage/avatars/${mainTeacher.photo}"),
                        ),
                      ),
                    ),
                    ListTile(
                      title: Text(
                        asistantTeacher.name,
                        style: const TextStyle(fontSize: 20),
                      ),
                      subtitle: Text(asistantTeacher.phone),
                      leading: CircleAvatar(
                        child: Container(
                          decoration: const BoxDecoration(
                              shape: BoxShape.circle, color: Colors.grey),
                          clipBehavior: Clip.hardEdge,
                          child: asistantTeacher.photo == null
                              ? const Icon(
                                  Icons.person,
                                  size: 40,
                                )
                              : Image.network(
                                  "http://millima.flutterwithakmaljon.uz/storage/avatars/${asistantTeacher.photo}"),
                        ),
                      ),
                    ),
                    const Text(
                      "Students",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: ListView.builder(
                    itemCount: students.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(
                          students[index].name,
                          style: const TextStyle(fontSize: 20),
                        ),
                        subtitle: Text(students[index].phone),
                        leading: CircleAvatar(
                          child: Container(
                            decoration: const BoxDecoration(
                                shape: BoxShape.circle, color: Colors.grey),
                            clipBehavior: Clip.hardEdge,
                            child: students[index].photo == null
                                ? const Icon(
                                    Icons.person,
                                    size: 40,
                                  )
                                : Image.network(
                                    "http://millima.flutterwithakmaljon.uz/storage/avatars/${students[index].photo}"),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          );
        }
        return const Center(
          child: Text("User topilmadi!"),
        );
      }),
    );
  }
}
