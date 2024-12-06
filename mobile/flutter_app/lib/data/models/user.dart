import 'package:equatable/equatable.dart';

class User extends Equatable {
  final int id;
  final String name;
  final String username;
  final String email;
  final String? googleId;
  final String? avatar;
  final String createdAt;
  final String updatedAt;
  final String? emailVerifiedAt;

  const User({
    required this.id,
    required this.name,
    required this.username,
    required this.email,
    this.googleId,
    this.avatar,
    required this.createdAt,
    required this.updatedAt,
    this.emailVerifiedAt,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      username: json['username'],
      email: json['email'],
      googleId: json['google_id'],
      avatar: json['avatar'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      emailVerifiedAt: json['email_verified_at'],
    );
  }

  @override
  List<Object?> get props => [id, name, email, createdAt, updatedAt];
}
