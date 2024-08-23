import 'dart:io';

import 'package:equatable/equatable.dart';

sealed class UserEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetUserEvent extends UserEvent {}

class UpdateUserEvent extends UserEvent {
  final String name;
  final String phone;
  final String? email;
  final File? phote;

  UpdateUserEvent({
    required this.name,
    required this.phone,
    required this.email,
    required this.phote,
  });
}
