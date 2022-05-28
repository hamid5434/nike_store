part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class AuthStated extends AuthEvent {}

class AuthButtonIsClicked extends AuthEvent {
  final String username;
  final String password;

  AuthButtonIsClicked(this.username, this.password);
}

class AuthModeChangeIsClicked extends AuthEvent {}

