//what to do with token , it is stored here
import 'package:shared_preferences/shared_preferences.dart';

class TokenService {
  static const String tokenKey = "jwt_token";

  Future<void> saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString(
      //shared prefs set key value pairre and store it locally
      tokenKey,
      token,
    );
  }

  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();

    return prefs.getString(tokenKey);
  }

  Future<void> removeToken() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.remove(tokenKey);
  }
}
