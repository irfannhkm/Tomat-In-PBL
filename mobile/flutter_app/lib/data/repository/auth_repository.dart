class AuthRepository {
  Future<void> login(String email, String password) async {
    
    if (email == "test@gmail.com" && password == "admin123") {
      await Future.delayed(const Duration(seconds: 1)); 
    } else {
      throw Exception("Email atau password salah.");
    }
  }
}
