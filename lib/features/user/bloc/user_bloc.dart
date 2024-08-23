import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:millima/data/models/models.dart';
import 'package:millima/data/services/user/user_service.dart';
import 'package:millima/features/user/bloc/user_event.dart';
import 'package:millima/features/user/bloc/user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc() : super(UserInitialState()) {
    on<GetUserEvent>(_onGetUser);
    on<UpdateUserEvent>(_updateUser);
  }

  Future<void> _onGetUser(GetUserEvent event, emit) async {
    emit(UserLoadingState());
    final UserService userService = UserService();
    try {
      final UserModel userModel = await userService.getUser();

      emit(UserLoadedState(user: userModel));
    } catch (e) {
      emit(UserErrorState(error: e.toString()));
    }
  }

  Future<void> _updateUser(UpdateUserEvent event, emit) async {
    emit(UserLoadingState());
    final UserService userService = UserService();
    try {
      await userService.updateProfile(
          name: event.name,
          email: event.email,
          phone: event.phone,
          photo: event.phote);
      add(GetUserEvent());
    } catch (e) {
      emit(UserErrorState(error: e.toString()));
    }
  }
}
