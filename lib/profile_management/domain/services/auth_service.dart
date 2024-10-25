import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:movil_application/profile_management/domain/model/user_model.dart';

class AuthService {
  final String baseUrl =
      'https://my-json-server.typicode.com/Debuggers-SW74/dbiot/users';

  Future<User?> login(String email, String password) async {
    try {
      final response = await http.get(Uri.parse(baseUrl));

      if (response.statusCode == 200) {
        List<dynamic> users = jsonDecode(response.body);

        // Buscar un usuario que coincida con el email y password
        for (var userJson in users) {
          User user = User.fromJson(userJson);
          if (user.email == email && user.password == password) {
            return user;
          }
        }
        return null; // Usuario no encontrado
      } else {
        throw Exception('Failed to load users');
      }
    } catch (e) {
      print('Error: $e');
      return null;
    }
  }
}