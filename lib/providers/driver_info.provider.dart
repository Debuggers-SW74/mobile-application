import 'dart:convert';

import 'package:fastporte/common/constants/shared_preferences_keys.constant.dart';
import 'package:fastporte/services/driver/driver.service.dart';
import 'package:fastporte/services/driver/update_driver.model.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/entities/driver.dart';

class DriverInfoProvider with ChangeNotifier {
  Driver? _driver;
  bool _isLoading = true;

  final DriverService _driverService = DriverService();
  late SharedPreferences _prefs;

  Driver? get driver => _driver;

  bool get isLoading => _isLoading;

  /*Future<bool> fetchClient() async {
    try {
      final response = await http.get(Uri.parse('https://randomuser.me/api/'));
      if (response.statusCode == 200) {
        _driver = Driver.fromJson(jsonDecode(response.body)['results'][0]);
        _saveDriverToPreferences(_driver!);
        notifyListeners();
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }*/

  // Método para obtener el conductor y actualizar el estado
  Future<void> fetchDriver() async {
    _isLoading = true;
    notifyListeners();

    try {
      Driver? fetchedDriver = await _driverService.getDriverById();
      if (fetchedDriver != null) {
        _driver = Driver.fromJson(fetchedDriver.toJson());
        _saveDriverToPreferences(_driver!);
      }
    } catch (e) {
      print('Error fetching driver: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> _saveDriverToPreferences(Driver driver) async {
    _prefs = await SharedPreferences.getInstance();
    _prefs.setString(SharedPreferencesKey.DRIVER, jsonEncode(driver.toJson()));
  }

  Future<void> _getDriverFromPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    final driverString = prefs.getString(SharedPreferencesKey.DRIVER);
    if (driverString != null) {
      _driver = Driver.fromJson(jsonDecode(driverString));
      notifyListeners();
    }
  }

  Future<bool> init() async {
    _isLoading = true;
    notifyListeners();

    await _getDriverFromPreferences();
    if (_driver == null) {
      _isLoading = false;
      notifyListeners();
      return false; //return await fetchClient();
    }

    _isLoading = false;
    notifyListeners();
    return true;
  }

  void updateDriver(Driver driver) {
    _driver = driver;
    _saveDriverToPreferences(driver);
    notifyListeners();
  }

  Future<bool> updateDriverProfileInfo(UpdateDriver driverToUpdate) async {
    _prefs = await SharedPreferences.getInstance();
    bool success = await _driverService.updateDriverById(driverToUpdate);

    if (success) {
      Driver newDriver = Driver(
        id: _driver!.id,
        name: driverToUpdate.name!,
        firstLastName: driverToUpdate.firstLastName!,
        secondLastName: driverToUpdate.secondLastName!,
        email: driverToUpdate.email!,
        phone: driverToUpdate.phone!,
        username: _driver!.username,
        supervisorId: _driver!.supervisorId,
        userId: _driver!.userId,
      );
      updateDriver(newDriver);
    } else {
      throw Exception('Failed to update driver details');
    }
    notifyListeners();
    return success;
  }

  void clearDriver() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove(SharedPreferencesKey.DRIVER_ID);
    prefs.remove(SharedPreferencesKey.DRIVER);
    prefs.remove(SharedPreferencesKey.TOKEN);
    _driver = null;
    notifyListeners();
  }
}
