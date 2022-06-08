import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:nike_store/common/exceptions.dart';
import 'package:nike_store/data/repo/auth_repository.dart';
import 'package:nike_store/data/repo/cart_repository.dart';

part 'auth_event.dart';

part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final IAuthRepository authRepository;
  final CartRepository cartRepository;
  bool isLoginMode;

  AuthBloc(
    this.authRepository, {
    required this.cartRepository,
    this.isLoginMode = true,
  }) : super(AuthInitial(isLoginMode)) {
    on<AuthEvent>((event, emit) async {
      try {
        if (event is AuthButtonIsClicked) {
          emit(AuthLoading(isLoginMode));
          if (isLoginMode) {
            await authRepository.login(
                username: event.username, password: event.password);
          } else {
            await authRepository.register(
                username: event.username, password: event.password);
          }
          await cartRepository.count();
          emit(AuthSuccess(isLoginMode));
        } else if (event is AuthModeChangeIsClicked) {
          isLoginMode = !isLoginMode;
          emit(AuthInitial(isLoginMode));
        }
      } catch (ex) {
        emit(
          AuthError(isLoginMode, AppException()),
        );
      }
    });
  }
}
