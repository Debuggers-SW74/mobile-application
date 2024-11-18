import 'dart:convert';
import 'package:fastporte/common/constants/shared_preferences_keys.constant.dart';
import 'package:fastporte/models/entities/supervisor.dart';
import 'package:fastporte/models/entities/register.model.dart';
import 'package:fastporte/providers/registration.provider.dart';
import 'package:fastporte/services/supervisor/update_supervisor.model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../../common/constants/environment_url.constant.dart';

class SupervisorService {
  final String baseUrl = EnvironmentConstants.CURRENT_ENV_URL;
  late SharedPreferences _prefs;

  Future<Supervisor?> getSupervisorById() async {
    try {
      // Obtén la instancia de SharedPreferences
      _prefs = await SharedPreferences.getInstance();
      final token = _prefs.getString(SharedPreferencesKey.TOKEN);
      final supervisorId = _prefs.getInt(SharedPreferencesKey.SUPERVISOR_ID);

      // Verifica si el token existe
      if (token == null || token.isEmpty) {
        throw Exception('Token not found');
      }

      // Realiza la solicitud HTTP GET con el token de autorización
      final response = await http.get(
        Uri.parse('$baseUrl/supervisors/$supervisorId'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token', // Token de autorización
        },
      );

      // Verifica el código de estado de la respuesta
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        Supervisor supervisor = Supervisor.fromJson(data);

        // Guarda los detalles del conductor en SharedPreferences
        await _saveSupervisorToPreferences(supervisor);
        return supervisor;
      } else {
        throw Exception('Failed to fetch supervisor details: ${response.body}');
      }
    } catch (e) {
      print('-> Error: $e');
      return null;
    }
  }

  Future<bool> updateSupervisorById(UpdateSupervisor updateSupervisor) async {
    try {

      _prefs = await SharedPreferences.getInstance();
      final token = _prefs.getString(SharedPreferencesKey.TOKEN);
      final supervisorId = _prefs.getInt(SharedPreferencesKey.SUPERVISOR_ID);

      // Verifica si el token existe
      if (token == null || token.isEmpty) {
        throw Exception('Token not found');
      }

      updateSupervisor.id = supervisorId;

      // Realiza la solicitud HTTP PUT con el token de autorización
      final response = await http.put(
        Uri.parse('$baseUrl/supervisors'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token', // Token de autorización
        },
        body: jsonEncode(updateSupervisor.toJson()),
      );
      print(updateSupervisor.toJson());
      print('-> Response: ${response.statusCode}');

      // Verifica el código de estado de la respuesta
      if (response.statusCode == 200 || response.statusCode == 201) {
        return true;
      } else {
        throw Exception('Failed to update supervisor details: ${response.body}');
      }
    } catch (e) {
      print('-> Error: $e');
      return false;
    }
  }

  Future<RegisterUserResponse> registerSupervisor(RegisterUSer registerUser) async {

    try {
      // Realiza la solicitud HTTP POST
      final response = await http.post(
        Uri.parse('$baseUrl/supervisors'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(registerUser.toJson()),
      );

      // Verifica el código de estado de la respuesta
      if (response.statusCode == 201) { //
        return RegisterUserResponse(success: true, message: 'Supervisor registered successfully');
      } else {
        //Solo obtener el campo message del body para devolverlo en el objeto
        var data = jsonDecode(response.body);
        return RegisterUserResponse(success: false, message: data['message']);
      }
    } catch (e) {
      print('-> Error: $e');
      return RegisterUserResponse(success: false, message: 'Error registering supervisor: $e');
    }
  }

  Future<void> _saveSupervisorToPreferences(Supervisor supervisor) async {
    _prefs = await SharedPreferences.getInstance();

    // Guarda los detalles del conductor como JSON en SharedPreferences
    _prefs.setString(SharedPreferencesKey.SUPERVISOR, jsonEncode(supervisor.toJson()));
  }
}
