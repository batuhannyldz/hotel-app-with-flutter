
class LoginService {
  static const String _correctUsername = 'admin';
  static const String _correctPassword = '123';

  static bool authenticate(String username, String password) {
    return username == _correctUsername && password == _correctPassword;
  }
}