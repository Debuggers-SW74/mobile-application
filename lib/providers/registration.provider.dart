import 'package:fastporte/models/entities/register.model.dart';
import 'package:flutter/foundation.dart';

import '../services/driver/driver.service.dart';

class RegistrationProvider with ChangeNotifier {
  final RegisterUSer _data = RegisterUSer();
  String _role = '';

  final DriverService _driverService = DriverService();

  // Métodos para actualizar los campos
  void setSensorCode(String sensorCode) {
    _data.sensorCode = sensorCode;
    notifyListeners();
  }

  void setRole(String role) {
    _role = role;
    notifyListeners();
  }

  void setAccountInformation(String email, String password) {
    _data.email = email;
    _data.password = password;
    notifyListeners();
  }

  void setPersonalInformation(String name, String firstLastName, String secondLastName, String phone) {
    _data.name = name;
    _data.firstLastName = firstLastName;
    _data.secondLastName = secondLastName;
    _data.phone = phone;
    _data.username = '${name[0].toLowerCase()}${firstLastName.toLowerCase()}';
    notifyListeners();
  }

  Future<RegisterUserResponse> register() async {
    RegisterUserResponse response;

    if(role == 'ROLE_DRIVER') {
      try {
        return await _driverService.registerDriver(_data);

      } catch (e) {
        response = RegisterUserResponse(success: false, message: 'Error registering driver: $e');
      }
    } else {
      response = RegisterUserResponse(success: false, message: 'Role not found');
    }

    return response;
  }

  // Método para obtener los datos completos
  RegisterUSer get data => _data;
  String get role => _role;
}

class RegisterUserResponse {
  final bool success;
  final String message;

  RegisterUserResponse({required this.success, required this.message});
}
