import 'dart:convert';
import 'package:fastporte/common/constants/shared_preferences_keys.constant.dart';
import 'package:fastporte/models/entities/driver.dart';
import 'package:fastporte/models/entities/register.model.dart';
import 'package:fastporte/providers/registration.provider.dart';
import 'package:fastporte/services/driver/update_driver.model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../../common/constants/environment_url.constant.dart';
import '../../models/entities/trip.model.dart';

class DriverService {
  final String baseUrl = EnvironmentConstants.CURRENT_ENV_URL;
  late SharedPreferences _prefs;

  Future<Driver?> getDriverById() async {
    try {
      // Obtén la instancia de SharedPreferences
      _prefs = await SharedPreferences.getInstance();
      final token = _prefs.getString(SharedPreferencesKey.TOKEN);
      final driverId = _prefs.getInt(SharedPreferencesKey.DRIVER_ID);

      // Verifica si el token existe
      if (token == null || token.isEmpty) {
        throw Exception('Token not found');
      }

      // Realiza la solicitud HTTP GET con el token de autorización
      final response = await http.get(
        Uri.parse('$baseUrl/drivers/$driverId'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token', // Token de autorización
        },
      );

      // Verifica el código de estado de la respuesta
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        Driver driver = Driver.fromJson(data);

        // Guarda los detalles del conductor en SharedPreferences
        await _saveDriverToPreferences(driver);
        return driver;
      } else {
        throw Exception('Failed to fetch driver details: ${response.body}');
      }
    } catch (e) {
      print('-> Error: $e');
      return null;
    }
  }

  Future<bool> updateDriverById(UpdateDriver updateDriver) async {
    try {

      _prefs = await SharedPreferences.getInstance();
      final token = _prefs.getString(SharedPreferencesKey.TOKEN);
      final driverId = _prefs.getInt(SharedPreferencesKey.DRIVER_ID);

      // Verifica si el token existe
      if (token == null || token.isEmpty) {
        throw Exception('Token not found');
      }

      updateDriver.id = driverId;

      // Realiza la solicitud HTTP PUT con el token de autorización
      final response = await http.put(
        Uri.parse('$baseUrl/drivers'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token', // Token de autorización
        },
        body: jsonEncode(updateDriver.toJson()),
      );
      print(updateDriver.toJson());
      print('-> Response: ${response.statusCode}');

      // Verifica el código de estado de la respuesta
      if (response.statusCode == 200) {
        return true;
      } else {
        throw Exception('Failed to update driver details: ${response.body}');
      }
    } catch (e) {
      print('-> Error: $e');
      return false;
    }
  }

  Future<RegisterUserResponse> registerDriver(RegisterUSer registerUser) async {

    try {
      // Realiza la solicitud HTTP POST
      final response = await http.post(
        Uri.parse('$baseUrl/drivers'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(registerUser.toJson()),
      );

      // Verifica el código de estado de la respuesta
      if (response.statusCode == 201) { //
        return RegisterUserResponse(success: true, message: 'Driver registered successfully');
      } else {
        //Solo obtener el campo message del body para devolverlo en el objeto
        var data = jsonDecode(response.body);
        return RegisterUserResponse(success: false, message: data['message']);
      }
    } catch (e) {
      print('-> Error: $e');
      return RegisterUserResponse(success: false, message: 'Error registering driver: $e');
    }
  }

  Future<void> _saveDriverToPreferences(Driver driver) async {
    _prefs = await SharedPreferences.getInstance();

    // Guarda los detalles del conductor como JSON en SharedPreferences
    _prefs.setString(SharedPreferencesKey.DRIVER, jsonEncode(driver.toJson()));
  }
}
