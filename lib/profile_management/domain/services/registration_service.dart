import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:movil_application/profile_management/domain/model/user_model.dart';

class RegistrationService {
  final String baseUrl = 'https://my-json-server.typicode.com/Debuggers-SW74/dbiot';

  Future<User> registerUser({
    required String email,
    required String password,
    required String userType,
    required String firstName,
    required String lastName,
    required String phoneNumber,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/users'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'email': email,
          'password': password,
          'role': userType,
          'firstName': firstName,  
          'lastName': lastName,   
          'phoneNumber': phoneNumber, 
        }),
      );

      if (response.statusCode == 201 || response.statusCode == 200) {
        final userData = json.decode(response.body);
        return User.fromJson(userData);
      } else {
        throw Exception('Failed to register user: ${response.statusCode}. Response: ${response.body}');
      }
    } catch (e) {
      throw Exception('Registration error: $e');
    }
  }
}