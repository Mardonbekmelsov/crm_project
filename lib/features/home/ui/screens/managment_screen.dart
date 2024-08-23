// ignore_for_file: use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:millima/features/user/bloc/user_bloc.dart';
import 'package:millima/features/user/bloc/user_event.dart';
import 'package:millima/features/user/bloc/user_state.dart';
import 'package:millima/features/user/ui/screens/admin_screen.dart';
import 'package:millima/features/user/ui/screens/teacher_screeen.dart';
import 'package:millima/features/user/ui/screens/user_screen.dart';
class ManagmentScreen extends StatefulWidget {
  const ManagmentScreen({super.key});

  @override
  State<ManagmentScreen> createState() => _ManagmentScreenState();
}

class _ManagmentScreenState extends State<ManagmentScreen> {
  @override
  void initState() {
    super.initState();
    context.read<UserBloc>().add(GetUserEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<UserBloc, UserState>(builder: (context, state) {
        if (state is UserLoadingState) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is UserErrorState) {
          return Center(
            child: Text(state.error),
          );
        }
        if (state is UserLoadedState) {
          if (state.user.role.name == "student") {
            return const UserScreen();
          } else if (state.user.role.name == 'teacher') {
            return const TeacherScreeen();
          } else if (state.user.role.name == 'admin') {
            return const AdminScreen();
          }
        }
        return const Center(
          child: Text("User topilmadi!"),
        );
      }),
    );
  }
}
