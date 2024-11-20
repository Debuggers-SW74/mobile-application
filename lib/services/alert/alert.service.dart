import 'dart:convert';
import 'package:fastporte/common/constants/shared_preferences_keys.constant.dart';
import 'package:fastporte/models/entities/alert.model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../../common/constants/environment_url.constant.dart';

class AlertService {
  final String baseUrl = EnvironmentConstants.CURRENT_ENV_URL;
  late SharedPreferences _prefs;

  Future<List<Alert>> getByTripId(int tripId) async {
    try {
      _prefs = await SharedPreferences.getInstance();
      final token = _prefs.getString(SharedPreferencesKey.TOKEN);

      // Verifica si el token existe
      if (token == null || token.isEmpty) {
        throw Exception('Token not found');
      }

      // Realiza la solicitud HTTP GET con el token de autorización
      final response = await http.get(
        Uri.parse('$baseUrl/alerts/trip/$tripId'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token', // Token de autorización
        },
      );

      // Verifica el código de estado de la respuesta
      if (response.statusCode == 200) {
        // Decodifica la respuesta JSON como una lista
        List<dynamic> data = jsonDecode(response.body);

        // Convierte cada elemento de la lista en un objeto Alert
        List<Alert> alerts = data.map((item) {
          return Alert.fromJson(item);
        }).toList();

        return alerts; // Devuelve la lista de Alert
      } else {
        throw Exception('Failed to fetch threshold details: ${response.body}');
      }
    } catch (e) {
      print('-> Error: $e');
      return []; // Devuelve una lista vacía en caso de error
    }
  }

  Future<AlertCreate> create(AlertCreate alert) async {
    try {
      _prefs = await SharedPreferences.getInstance();
      final token = _prefs.getString(SharedPreferencesKey.TOKEN);

      // Verifica si el token existe
      if (token == null || token.isEmpty) {
        throw Exception('Token not found');
      }

      // Realiza la solicitud HTTP POST con el token de autorización
      final response = await http.post(
        Uri.parse('$baseUrl/alerts'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token', // Token de autorización
        },
        body: jsonEncode(alert.toJson()), // Convierte el objeto Alert a JSON
      );

      // Verifica el código de estado de la respuesta
      if (response.statusCode == 201) {
        // Decodifica la respuesta JSON como un objeto Alert
        AlertCreate newAlert = AlertCreate.fromJson(jsonDecode(response.body));
        return newAlert; // Devuelve el objeto Alert
      } else {
        throw Exception('Failed to create alert: ${response.body}');
      }
    } catch (e) {
      print('-> Error: $e');
      return AlertCreate(); // Devuelve un objeto Alert vacío en caso de error
    }
  }
}
