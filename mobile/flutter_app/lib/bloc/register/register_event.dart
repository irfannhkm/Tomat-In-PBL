import 'package:equatable/equatable.dart';

abstract class RegisterEvent extends Equatable {

  @override
  List<Object> get props => [];
}

class RegisterRequested extends RegisterEvent {
  
  final String username;
  final String name;
  final String email;
  final String password;
  final String cPassword;

  RegisterRequested({required this.email, required this.password, required this.cPassword, required this.name, required this.username});

  @override
  List<Object> get props => [email, password];
}

// class SignUpRequested extends RegisterEvent {
//   final String username;
//   final String fullName;
//   final String email;
//   final String password;

//   SignUpRequested({
//     required this.username,
//     required this.fullName,
//     required this.email,
//     required this.password,
//   });

//   @override
//   List<Object> get props => [username, fullName, email, password];
// }


