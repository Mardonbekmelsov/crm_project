import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:millima/features/authentication/bloc/authentication_bloc.dart';
import 'package:millima/features/groups/bloc/group_bloc.dart';
import 'package:millima/features/user/bloc/user_bloc.dart';
import 'package:millima/features/users/bloc/users_bloc.dart';

import 'locator.dart';

final providers = [
  BlocProvider<UserBloc>.value(value: getIt.get<UserBloc>()),
  BlocProvider<UsersBloc>.value(value: getIt.get<UsersBloc>()),
  BlocProvider<GroupBloc>.value(value: getIt.get<GroupBloc>()),
  BlocProvider<AuthenticationBloc>.value(
      value: getIt.get<AuthenticationBloc>()),
];
