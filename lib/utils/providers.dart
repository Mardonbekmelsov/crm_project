import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:millima/features/authentication/bloc/authentication_bloc.dart';
import 'package:millima/features/groups/bloc/group_bloc.dart';
import 'package:millima/features/rooms/bloc/room_bloc.dart';
import 'package:millima/features/subject/bloc/subject_bloc.dart';
import 'package:millima/features/timetable/bloc/timetable_bloc.dart';
import 'package:millima/features/user/bloc/user_bloc.dart';
import 'package:millima/features/users/bloc/users_bloc.dart';

import 'locator.dart';

final providers = [
  BlocProvider<UserBloc>.value(value: getIt.get<UserBloc>()),
  BlocProvider<UsersBloc>.value(value: getIt.get<UsersBloc>()),
  BlocProvider<GroupBloc>.value(value: getIt.get<GroupBloc>()),
  BlocProvider<RoomBloc>.value(value: getIt.get<RoomBloc>()),
  BlocProvider<TimetableBloc>.value(value: getIt.get<TimetableBloc>()),
  BlocProvider<SubjectBloc>.value(value: getIt.get<SubjectBloc>()),
  BlocProvider<AuthenticationBloc>.value(
      value: getIt.get<AuthenticationBloc>()),
];
