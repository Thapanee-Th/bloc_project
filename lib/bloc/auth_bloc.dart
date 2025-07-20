import 'package:bloc_project/services/api_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class AuthEvent {}

class LoginRequested extends AuthEvent {
  final String username;
  final String password;
  LoginRequested(this.username, this.password);
}

abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthSuccess extends AuthState {}

class AuthFailure extends AuthState {
  final String message;
  AuthFailure(this.message);
}

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final _apiService = ApiService();

  AuthBloc() : super(AuthInitial()) {
    on<LoginRequested>((event, emit) async {
      emit(AuthLoading());
      try {
        final token = await _apiService.login(event.username, event.password);
        // Save JWT using jwt_service.dart
        emit(AuthSuccess());
      } catch (e) {
        emit(AuthFailure(e.toString()));
      }
    });
  }
}
