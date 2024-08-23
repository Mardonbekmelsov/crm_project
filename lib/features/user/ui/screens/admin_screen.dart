import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:millima/data/models/group/group_model.dart';
import 'package:millima/features/authentication/bloc/authentication_bloc.dart';
import 'package:millima/features/groups/bloc/group_bloc.dart';
import 'package:millima/features/groups/bloc/group_event.dart';
import 'package:millima/features/groups/bloc/group_state.dart';
import 'package:millima/features/groups/ui/screens/add_student_to_group.dart';
import 'package:millima/features/groups/ui/screens/group_information_screen.dart';
import 'package:millima/features/groups/ui/screens/update_group.dart';
import 'package:millima/features/user/ui/widgets/custom_drawer_for_admin.dart';
class AdminScreen extends StatefulWidget {
  const AdminScreen({super.key});

  @override
  State<AdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<GroupModel> filteredGroups = [];

  @override
  void initState() {
    super.initState();
    context.read<GroupBloc>().add(GetGroupsEvent());
  }

  void _filterGroups(String query, List<GroupModel> groups) {
    setState(() {
      filteredGroups = groups
          .where(
              (group) => group.name.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF4F9FD),
      drawer: const CustomDrawerForAdmin(),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              context.read<AuthenticationBloc>().add(LogoutEvent());
              Navigator.pushReplacementNamed(context, '/');
            },
          ),
        ],
        title: const Text(
          "Admin Panel",
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(60.0),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 45,
              padding: const EdgeInsets.symmetric(horizontal: 15),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: Colors.grey),
              ),
              child: TextField(
                controller: _searchController,
                decoration: const InputDecoration(
                  hintText: 'Search groups...',
                  border: InputBorder.none,
                  icon: Icon(Icons.search),
                ),
                onChanged: (value) {
                  context.read<GroupBloc>().add(GetGroupsEvent());
                },
              ),
            ),
          ),
        ),
      ),
      body: BlocBuilder<GroupBloc, GroupState>(builder: (context, state) {
        if (state is GroupLoadingState) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is GroupErrorState) {
          return Center(
            child: Text(state.error),
          );
        }
        if (state is GroupLoadedState) {
          final groups = _searchController.text.isEmpty
              ? state.groups
              : state.groups
                  .where((group) => group.name
                      .toLowerCase()
                      .contains(_searchController.text.toLowerCase()))
                  .toList();

          if (groups.isEmpty) {
            return const Center(
              child: Text('No groups found.'),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            itemCount: groups.length,
            itemBuilder: (context, index) {
              return InkWell(
                splashColor: Colors.transparent,
                hoverColor: Colors.transparent,
                highlightColor: Colors.transparent,
                onLongPress: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          actionsPadding: const EdgeInsets.all(8),
                          title: Text(groups[index].name),
                          actions: [
                            Row(
                              children: [
                                TextButton.icon(
                                  onPressed: () {
                                    Navigator.pop(context);
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              UpdateGroup(group: groups[index]),
                                        ));
                                  },
                                  label: const Text("Edit Group"),
                                  icon: const Icon(Icons.edit_document),
                                ),
                                TextButton.icon(
                                  onPressed: () {
                                    Navigator.pop(context);
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              AddStudentToGroupScreen(
                                                  groupModel: groups[index]),
                                        ));
                                  },
                                  label: const Text("Add Students"),
                                  icon: const Icon(Icons.person_add),
                                ),
                              ],
                            )
                          ],
                        );
                      });
                },
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => GroupInformationScreen(
                          groupModel: groups[index],
                        ),
                      ));
                },
                child: Container(
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
                              "Group Name: ${groups[index].name}",
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
                              "Main Teacher ID: ${groups[index].main_teacher_id}",
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
                          const Icon(Icons.person_outline,
                              color: Colors.white, size: 24),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              "Assistant Teacher ID: ${groups[index].assistant_teacher_id}",
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
                    ],
                  ),
                ),
              );
            },
          );
        }
        return const Center(
          child: Text("Grouplar topilmadi!"),
        );
      }),
    );
  }
}
