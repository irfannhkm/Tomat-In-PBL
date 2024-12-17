import 'package:equatable/equatable.dart';

class User extends Equatable {
  final int id;
  final String name;
  final String username;
  final String email;
  final String? googleId;
  final String? avatar;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? emailVerifiedAt;

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
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      emailVerifiedAt: json['email_verified_at'] != null
          ? DateTime.parse(json['email_verified_at'])
          : null,
    );
  }

   Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'username': username,
      'email': email,
      'google_id': googleId,
      'avatar': avatar,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'email_verified_at': emailVerifiedAt?.toIso8601String(),
    };
  }

  String get avatarUrl {
    if (avatar != null && avatar!.isNotEmpty) {
      return 'https://tomatin.my.id/storage/$avatar';
    } else {
      return '';
    }
  }

  @override
  List<Object?> get props => [id, name, email, createdAt, updatedAt];
}
