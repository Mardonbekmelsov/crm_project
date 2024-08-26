import 'package:get_it/get_it.dart';
import 'package:millima/data/services/authentication/authentication_service.dart';
import 'package:millima/data/services/authentication/local_authentication_service.dart';
import 'package:millima/data/services/user/user_service.dart';
import 'package:millima/domain/authentication_repository/authentication_repository.dart';
import 'package:millima/domain/user_repository/user_repository.dart';
import 'package:millima/features/authentication/bloc/authentication_bloc.dart';
import 'package:millima/features/groups/bloc/group_bloc.dart';
import 'package:millima/features/rooms/bloc/room_bloc.dart';
import 'package:millima/features/user/bloc/user_bloc.dart';
import 'package:millima/features/users/bloc/users_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

final getIt = GetIt.instance;

Future<void> dependencySetUp() async {
  final prefs = await SharedPreferences.getInstance();
  getIt.registerSingleton<SharedPreferences>(prefs);

  // SERVICES
  getIt.registerSingleton(AuthenticationService());
  getIt.registerSingleton(LocalAuthenticationService());
  getIt.registerSingleton(UserService());

  // REPOSITORIES
  getIt.registerSingleton(
    AuthenticationRepository(
      authenticationService: getIt.get<AuthenticationService>(),
      localAuthenticationService: getIt.get<LocalAuthenticationService>(),
    ),
  );
  getIt.registerSingleton(
    UserRepository(
      userService: getIt.get<UserService>(),
    ),
  );

  // BLOCS
  getIt.registerLazySingleton<UserBloc>(
    () => UserBloc(),
  );
  getIt.registerLazySingleton<UsersBloc>(
    () => UsersBloc(),
  );
  getIt.registerLazySingleton<GroupBloc>(
    () => GroupBloc(),
  );
  getIt.registerLazySingleton<RoomBloc>(
    () => RoomBloc(),
  );

  getIt.registerLazySingleton<AuthenticationBloc>(
    () => AuthenticationBloc(
      authenticationRepository: getIt.get<AuthenticationRepository>(),
    )..add(CheckAuthStatusEvent()),
  );
}
