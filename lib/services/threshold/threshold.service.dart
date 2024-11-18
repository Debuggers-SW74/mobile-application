import 'dart:convert';
import 'package:fastporte/common/constants/shared_preferences_keys.constant.dart';
import 'package:fastporte/models/entities/threshold.model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../../common/constants/environment_url.constant.dart';

import '../../models/entities/threshold.model.dart' as th;

class ThresholdService {
  final String baseUrl = EnvironmentConstants.CURRENT_ENV_URL;
  late SharedPreferences _prefs;

  Future<List<th.Threshold>> getByTripId(int tripId) async {
    try {
      _prefs = await SharedPreferences.getInstance();
      final token = _prefs.getString(SharedPreferencesKey.TOKEN);

      // Verifica si el token existe
      if (token == null || token.isEmpty) {
        throw Exception('Token not found');
      }

      // Realiza la solicitud HTTP GET con el token de autorización
      final response = await http.get(
        Uri.parse('$baseUrl/thresholds/trip/$tripId'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token', // Token de autorización
        },
      );

      // Verifica el código de estado de la respuesta
      if (response.statusCode == 200) {
        // Decodifica la respuesta JSON como una lista
        List<dynamic> data = jsonDecode(response.body);

        print(response.body);

        // Convierte cada elemento de la lista en un objeto Threshold
        List<th.Threshold> thresholds = data.map((item) {
          return Threshold.fromJson(item);
        }).toList();

        return thresholds; // Devuelve la lista de Thresholds
      } else {
        throw Exception('Failed to fetch threshold details: ${response.body}');
      }
    } catch (e) {
      print('-> Error: $e');
      return []; // Devuelve una lista vacía en caso de error
    }
  }
}
