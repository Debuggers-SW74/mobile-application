import 'dart:convert';

import 'package:fastporte/common/constants/shared_preferences_keys.constant.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../../common/constants/environment_url.constant.dart';
import '../../models/entities/trip.model.dart';

class TripService{
  final String baseUrl = EnvironmentConstants.CURRENT_ENV_URL;
  late SharedPreferences _prefs;

  /* ---------------------------------- */

  Future<List<Trip>> getTripsByDriverId() async {
    return getTripsByUserId('driver');
  }

  Future<List<Trip>> getTripsBySupervisorId() async {
    return getTripsByUserId('supervisor');
  }

  // driver o supervisor
  Future<List<Trip>> getTripsByUserId(String typeUser) async {
    try {
      // Obtén la instancia de SharedPreferences
      _prefs = await SharedPreferences.getInstance();
      final token = _prefs.getString(SharedPreferencesKey.TOKEN);
      int? typeUserId;

      if(typeUser == 'driver') {
        typeUserId = _prefs.getInt(SharedPreferencesKey.DRIVER_ID);
      } else if (typeUser == 'supervisor') {
        typeUserId = _prefs.getInt(SharedPreferencesKey.SUPERVISOR_ID);
      }

      // Verifica si el token existe
      if (token == null || token.isEmpty) {
        throw Exception('Token not found');
      }

      // Realiza la solicitud HTTP GET con el token de autorización
      final response = await http.get(
        Uri.parse('$baseUrl/trips/$typeUser/$typeUserId'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token', // Token de autorización
        },
      );

      // Verifica el código de estado de la respuesta
      if (response.statusCode == 200) {
        var data = jsonDecode(utf8.decode(response.bodyBytes));
        if (data is List) {
          List<Trip> trips = data.map((trip) => Trip.fromJson(trip as Map<String, dynamic>)).toList();
          print('---> Funciona');
          return trips;
        } else {
          throw Exception('Unexpected data format');
        }

      } else if(response.statusCode == 204) {
        return [];

      } else {
        throw Exception('Failed to fetch $typeUser trips: ${response.body}');

      }
    } catch (e) {
      print('-> Error: $e');
      return [];
    }
  }

  /* ---------------------------------- */

  Future<List<Trip>> getTripsByDriverIdAndStatusId(int statusId) async {
    return getTripsByUserIdAndStatusId('driver', statusId);
  }

  Future<List<Trip>> getTripsBySupervisorIdAndStatusId(int statusId) async {
    return getTripsByUserIdAndStatusId('supervisor', statusId);
  }

  // driver o supervisor
  Future<List<Trip>> getTripsByUserIdAndStatusId(String typeUser, int statusId) async {
    try {
      // Obtén la instancia de SharedPreferences
      _prefs = await SharedPreferences.getInstance();
      final token = _prefs.getString(SharedPreferencesKey.TOKEN);

      int? typeUserId;

      if(typeUser == 'driver') {
        typeUserId = _prefs.getInt(SharedPreferencesKey.DRIVER_ID);
      } else if (typeUser == 'supervisor') {
        typeUserId = _prefs.getInt(SharedPreferencesKey.SUPERVISOR_ID);
      }

      // Verifica si el token existe
      if (token == null || token.isEmpty) {
        throw Exception('Token not found');
      }

      // Realiza la solicitud HTTP GET con el token de autorización
      final response = await http.get(
        Uri.parse('$baseUrl/trips/$typeUser/$typeUserId/status/$statusId'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token', // Token de autorización
        },
      );

      // Verifica el código de estado de la respuesta
      if (response.statusCode == 200) {
        var data = jsonDecode(utf8.decode(response.bodyBytes));
        if (data is List) {
          List<Trip> trips = data.map((trip) => Trip.fromJson(trip as Map<String, dynamic>)).toList();
          return trips;
        } else {
          throw Exception('Unexpected data format');
        }

      } else if(response.statusCode == 204) {
        return [];

      } else {
        throw Exception('Failed to fetch driver details: ${response.body}');

      }
    } catch (e) {
      print('-> Error: $e');
      return [];
    }
  }

  /* ---------------------------------- */
  // Change trips status

  Future<bool> changeTripStatusToStart(int tripId) async {
    return changeTripStatus(tripId, 'starts');
  }

  Future<bool> changeTripStatusToFinish(int tripId) async {
    return changeTripStatus(tripId, 'completions');
  }

  Future<bool> changeTripStatusToCancel(int tripId) async {
    return changeTripStatus(tripId, 'cancellations');
  }

  Future<bool> changeTripStatus(int tripId, String status) async {
    try {
      // Obtén la instancia de SharedPreferences
      _prefs = await SharedPreferences.getInstance();
      final token = _prefs.getString(SharedPreferencesKey.TOKEN);

      // Verifica si el token existe
      if (token == null || token.isEmpty) {
        throw Exception('Token not found');
      }

      // Realiza la solicitud HTTP POST con el token de autorización
      final response = await http.post(
        Uri.parse('$baseUrl/trips/$tripId/$status'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token', // Token de autorización
        },
      );

      //print a url
      print('$baseUrl/trips/$tripId/$status');

      // Verifica el código de estado de la respuesta
      if (response.statusCode == 200) {
        return true;
      } else {
        throw Exception('Failed to change trip status: ${response.body}');
      }
    } catch (e) {
      print('-> Error: $e');
      return false;
    }
  }

}