import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:millima/data/models/models.dart';
import 'package:millima/data/services/user/user_service.dart';
import 'package:millima/features/users/bloc/users_event.dart';
import 'package:millima/features/users/bloc/users_state.dart';

class UsersBloc extends Bloc<UsersEvent, UsersState> {
  UsersBloc() : super(UsersInitialState()) {
    on<GetUsersEvent>(_onGetUsers);
  }

  Future<void> _onGetUsers(GetUsersEvent event, emit) async {
    emit(UsersLoadingState());
    final UserService userService = UserService();
    try {
      final Map<String, dynamic> response = await userService.getUsers();
      List<UserModel> users = [];

      response['data'].forEach(
        (value) {
          users.add(UserModel(
              id: value['id'],
              name: value['name'],
              email: value['email'],
              phone: value['phone'],
              photo: value['photo'],
              roleId: value['role_id'],
              role: Role.fromMap(value['role'])));
        },
      );
      emit(UsersLoadedState(users: users));
    } catch (e) {
      emit(UsersErrorState(error: e.toString()));
    }
  }
}
