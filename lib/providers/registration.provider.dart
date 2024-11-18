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

  Future<bool> register() async {
    if(role == 'ROLE_DRIVER') {
      try {
        return await _driverService.registerDriver(_data);
      } catch (e) {
        print('Error registering driver: $e');
        return false;
      }
    } else {
      return false;

    }
  }

  // Método para obtener los datos completos
  RegisterUSer get data => _data;
  String get role => _role;
}
