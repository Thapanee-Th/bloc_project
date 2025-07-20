import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/user.dart';
import '../services/api_service.dart';

/// Events
abstract class ProfileEvent {}

class FetchProfile extends ProfileEvent {}

/// States
abstract class ProfileState {}

class ProfileInitial extends ProfileState {}

class ProfileLoading extends ProfileState {}

class ProfileLoaded extends ProfileState {
  final User user;
  ProfileLoaded(this.user);
}

class ProfileError extends ProfileState {
  final String message;
  ProfileError(this.message);
}

/// BLoC
class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final ApiService _apiService = ApiService();

  ProfileBloc() : super(ProfileInitial()) {
    on<FetchProfile>((event, emit) async {
      emit(ProfileLoading());
      try {
        final data = await _apiService.fetchProfile();
        final user = User.fromJson(data);
        emit(ProfileLoaded(user));
      } catch (e) {
        emit(ProfileError(e.toString()));
      }
    });
  }
}
