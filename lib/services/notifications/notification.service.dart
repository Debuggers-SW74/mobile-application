import 'dart:convert';

import 'package:fastporte/common/constants/shared_preferences_keys.constant.dart';
import 'package:fastporte/models/entities/driver.dart';
import 'package:fastporte/models/entities/notification.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../../common/constants/environment_url.constant.dart';

class NotificationService {
  final String baseUrl = EnvironmentConstants.CURRENT_ENV_URL;
  late SharedPreferences _prefs;

  Future<List<UserNotification>> getNotificationByUserId() async {
    try {
      // Obtén la instancia de SharedPreferences
      _prefs = await SharedPreferences.getInstance();
      final token = _prefs.getString(SharedPreferencesKey.TOKEN);
      Driver driver = Driver.fromJson(jsonDecode(_prefs.getString(SharedPreferencesKey.DRIVER)!));

      final userId = driver.userId;

      // Verifica si el token existe
      if (token == null || token.isEmpty) {
        throw Exception('Token not found');
      }

      // Realiza la solicitud HTTP GET con el token de autorización
      final response = await http.get(
        Uri.parse('$baseUrl/notifications/$userId/users'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token', // Token de autorización
        },
      );

      // Verifica el código de estado de la respuesta
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        if (data is List) {
          List<UserNotification> notifications = data.map((notification) => UserNotification.fromJson(notification as Map<String, dynamic>)).toList();
          print('---> Funciona getNotificationByUserId');
          return notifications;
        } else {
          throw Exception('Unexpected data format');
        }

      } else if(response.statusCode == 204) {
        return [];

      } else {
        throw Exception('Failed to fetch driver notifications: ${response.body}');

      }
    } catch (e) {
      print('-> Error: $e');
      return [];
    }
  }
}