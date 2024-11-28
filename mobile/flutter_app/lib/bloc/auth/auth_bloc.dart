import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tomatin/data/repository/auth_repository.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;

  AuthBloc({required this.authRepository}) : super(AuthInitial()) {
    on<LoginRequested>((event, emit) async {
      emit(AuthLoading());

      try {
        final response =
            await authRepository.login(event.email, event.password);
        if (response.success && response.user != null) {
          emit(AuthSuccess(response.user!));
        } else {
          emit(AuthFailure(response.message));
        }
      } catch (error) {
        emit(AuthFailure('Terjadi kesalahan'));
      }
    });
  }
}
