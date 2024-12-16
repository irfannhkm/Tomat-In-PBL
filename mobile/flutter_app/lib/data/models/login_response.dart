import 'package:tomatin/data/models/login_data.dart';
import 'dart:convert';

// LoginResponse loginResponseFromJson(String str) =>
//     LoginResponse.fromJson(json.decode(str));

// String loginResponseToJson(LoginResponse data) => json.encode(data.toJson());

class LoginResponse {
  final bool success;
  final LoginData? data;
  final String message;

  LoginResponse({
    required this.success,
    this.data,
    required this.message,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      success: json['success'] ?? false,
      data: json['data'] != null ? LoginData.fromJson(json['data']) : null,
      message: json['message'],
    );
  }
  // factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse(
  //       success: json["success"],
  //       data: json["data"] == null ? null : Data.fromJson(json["data"]),
  //       message: json["message"],
  //     );

  // Map<String, dynamic> toJson() => {
  //       "success": success,
  //       "data": data?.toJson(),
  //       "message": message,
  //     };
}

class Data {
  final String? token;
  final User? user;

  Data({
    this.token,
    this.user,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        token: json["token"],
        user: json["user"] == null ? null : User.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "token": token,
        "user": user?.toJson(),
      };
}

class User {
  final int? id;
  final String? name;
  final String? username;
  final String? email;
  final dynamic googleId;
  final String? avatar;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final dynamic emailVerifiedAt;

  User({
    this.id,
    this.name,
    this.username,
    this.email,
    this.googleId,
    this.avatar,
    this.createdAt,
    this.updatedAt,
    this.emailVerifiedAt,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        name: json["name"],
        username: json["username"],
        email: json["email"],
        googleId: json["google_id"],
        avatar: json["avatar"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        emailVerifiedAt: json["email_verified_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "username": username,
        "email": email,
        "google_id": googleId,
        "avatar": avatar,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "email_verified_at": emailVerifiedAt,
      };
}
