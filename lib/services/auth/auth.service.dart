import 'dart:convert';

import 'package:fastporte/common/constants/role_type.constant.dart';
import 'package:fastporte/common/constants/shared_preferences_keys.constant.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../common/constants/environment_url.constant.dart';
import 'package:http/http.dart' as http;

class AuthService {
  final String baseUrl = EnvironmentConstants.CURRENT_ENV_URL;
  late SharedPreferences _prefs;

  Future<String?> login(String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/auth'), // Endpoint de autenticación
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email, 'password': password}),
      );

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);

        String token = data['token'];
        if (token.isNotEmpty) {
          //Decodificar el token jwt y devolver el rol
          String? role = _getValueFromToken(token, SharedPreferencesKey.ROLE);
          int? userId = _getValueFromToken(token, 'id');

          // Guardar el token en SharedPreferences
          await _saveTokenToPreferences(SharedPreferencesKey.TOKEN, token);
          await _saveTokenToPreferences(SharedPreferencesKey.ROLE, role!);

          if(role == RoleType.DRIVER) {

            await _saveTokenToPreferences(SharedPreferencesKey.DRIVER_ID, userId!);

          } else if(role == RoleType.SUPERVISOR) {

            await _saveTokenToPreferences(SharedPreferencesKey.SUPERVISOR_ID, userId!);
          }

          return role;

        } else {
          throw Exception('Token not found');
        }
      } else {
        throw Exception('Authentication error: ${response.body}');
      }
    } catch (e) {
      print('--> Error: $e');
      return null;
    }
  }

  Future<void> _saveTokenToPreferences(String key, dynamic value) async {
    _prefs = await SharedPreferences.getInstance();
    if(value is int) {
      print('Saving as int');
      _prefs.setInt(key, value);
    } else {
      print('Saving as string');
      _prefs.setString(key, value);
    }
  }

  // Método para obtener el rol del token
  dynamic _getValueFromToken(String token, String claim) {
    // Los tokens JWT están en formato: header.payload.signature
    final parts = token.split('.');
    if (parts.length != 3) {
      throw Exception('Invalid token format');
    }

    final payload = parts[1];
    var normalized = base64Url.normalize(payload); // Normaliza el payload para decodificación
    var decodedBytes = base64Url.decode(normalized);
    var decodedString = utf8.decode(decodedBytes);

    final payloadMap = jsonDecode(decodedString);
    if (payloadMap is! Map<String, dynamic>) {
      throw Exception('Invalid payload in token');
    }

    if (payloadMap.containsKey(claim)) {
      return payloadMap[claim];
    } else {
      throw Exception('Claim not found in token');
    }
  }
}
