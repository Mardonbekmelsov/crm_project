import 'package:equatable/equatable.dart';
import 'package:millima/data/models/models.dart';

sealed class UserState extends Equatable {
  @override
  List<Object> get props => [];
}

class UserInitialState extends UserState {}

class UserLoadingState extends UserState {}

class UserLoadedState extends UserState {
  final UserModel user;

  UserLoadedState({required this.user});
}

class UserErrorState extends UserState {
  final String error;
  UserErrorState({required this.error});
}
