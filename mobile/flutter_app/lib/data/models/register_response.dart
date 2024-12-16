class RegisterResponse {
  final bool success;
  final String message;
  final Map<String, dynamic>? data;

  RegisterResponse({
    required this.success,
    required this.message,
    this.data,
  });

  factory RegisterResponse.fromJson(Map<String, dynamic> json) {
    return RegisterResponse(
      success: json['success'],
      message: json['message'],
      data: json['data'],
    );
  }
}
