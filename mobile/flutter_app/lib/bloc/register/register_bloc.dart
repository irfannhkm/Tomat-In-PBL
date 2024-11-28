import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:tomatin/data/repository/register_repository.dart';
import 'register_event.dart';
import 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final RegisterRepository registerRepository;
  
  RegisterBloc({required this.registerRepository}) : super(RegisterInitial()) {
    on<RegisterRequested>((event, emit) async {
      emit(RegisterLoading());

      try {
        final response = await registerRepository.register(event);
        if (response.success && response.user != null) {
          emit(RegisterSuccess(response.user!));
        } else {
          emit(RegisterFailure(response.message));
        }
      } catch (error) {
        emit(RegisterFailure('Terjadi kesalahan'));
      }
    });
  }
}
