import 'dart:convert';

import 'package:fastporte/common/constants/shared_preferences_keys.constant.dart';
import 'package:fastporte/models/entities/driver.dart';
import 'package:fastporte/models/entities/notification.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../../common/constants/environment_url.constant.dart';
import '../../models/entities/supervisor.dart';

class NotificationService {
  final String baseUrl = EnvironmentConstants.CURRENT_ENV_URL;
  late SharedPreferences _prefs;

  Future<List<UserNotification>> getNotificationByUserId(String typeUser) async {
    try {
      // Obtén la instancia de SharedPreferences
      _prefs = await SharedPreferences.getInstance();
      final token = _prefs.getString(SharedPreferencesKey.TOKEN);
      int userId;

      if(typeUser == 'driver') {
        Driver driver = Driver.fromJson(jsonDecode(_prefs.getString(SharedPreferencesKey.DRIVER)!));
        userId = driver.userId;
      } else if (typeUser == 'supervisor') {
        Supervisor supervisor = Supervisor.fromJson(jsonDecode(_prefs.getString(SharedPreferencesKey.SUPERVISOR)!));
        userId = supervisor.userId;
      } else {
        throw Exception('Invalid user type');
      }

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
          List<UserNotification> notifications = data
              .map((notification) => UserNotification.fromJson(notification as Map<String, dynamic>))
              .toList();

          // Filtrar notificaciones con timestamp nulo y luego ordenar
          notifications = notifications.where((n) => n.timestamp != null).toList();

          // Ordenar las notificaciones por timestamp en orden descendente (más reciente primero)
          notifications.sort((a, b) {
            DateTime dateA = DateTime.parse(a.timestamp!);
            DateTime dateB = DateTime.parse(b.timestamp!);
            return dateB.compareTo(dateA); // Orden descendente
          });

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