import 'package:equatable/equatable.dart';
import 'package:tomatin/data/models/user.dart';

abstract class RegisterState extends Equatable {

  @override
  List<Object> get props => [];
}

class RegisterInitial extends RegisterState {}

class RegisterLoading extends RegisterState {}

class RegisterSuccess extends RegisterState {
  final User user; 

  RegisterSuccess(this.user);

  @override
  List<Object> get props => [user];
}

class RegisterFailure extends RegisterState {
  final String message;

  RegisterFailure(this.message);

  @override
  List<Object> get props => [message];
}
