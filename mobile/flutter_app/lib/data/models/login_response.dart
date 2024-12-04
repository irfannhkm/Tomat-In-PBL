
class LoginResponse {
  final bool success;
  final String? data;
  final String message;

  LoginResponse({
    required this.success,
    this.data,
    required this.message,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      success: json['success'] ?? false,
      data: json['data']?.toString(),
      message: json['message'],
    );
  }
}
