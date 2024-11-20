import 'dart:convert';

import 'package:fastporte/common/constants/shared_preferences_keys.constant.dart';
import 'package:fastporte/models/entities/supervisor.dart';
import 'package:fastporte/services/supervisor/supervisor.service.dart';
import 'package:fastporte/services/supervisor/update_supervisor.model.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SupervisorInfoProvider with ChangeNotifier {
  Supervisor? _supervisor;
  bool _isLoading = true;

  final SupervisorService _supervisorService = SupervisorService();
  late SharedPreferences _prefs;

  Supervisor? get supervisor => _supervisor;

  bool get isLoading => _isLoading;

  // Método para obtener el conductor y actualizar el estado
  Future<void> fetchSupervisor() async {
    _isLoading = true;
    notifyListeners();

    try {
      Supervisor? fetchedSupervisor = await _supervisorService.getSupervisorById();
      if (fetchedSupervisor != null) {
        _supervisor = Supervisor.fromJson(fetchedSupervisor.toJson());
        _saveSupervisorToPreferences(_supervisor!);
      }
    } catch (e) {
      print('Error fetching supervisor: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> _saveSupervisorToPreferences(Supervisor supervisor) async {
    _prefs = await SharedPreferences.getInstance();
    _prefs.setString(SharedPreferencesKey.SUPERVISOR, jsonEncode(supervisor.toJson()));
  }

  Future<void> _getSupervisorFromPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    final supervisorString = prefs.getString(SharedPreferencesKey.SUPERVISOR);
    if (supervisorString != null) {
      _supervisor = Supervisor.fromJson(jsonDecode(supervisorString));
      notifyListeners();
    }
  }

  Future<bool> init() async {
    _isLoading = true;
    notifyListeners();

    await _getSupervisorFromPreferences();
    if (_supervisor == null) {
      _isLoading = false;
      notifyListeners();
      return false; //return await fetchClient();
    }

    _isLoading = false;
    notifyListeners();
    return true;
  }

  void updateSupervisor(Supervisor supervisor) {
    _supervisor = supervisor;
    _saveSupervisorToPreferences(supervisor);
    notifyListeners();
  }

  Future<bool> updateSupervisorProfileInfo(UpdateSupervisor supervisorToUpdate) async {
    _prefs = await SharedPreferences.getInstance();
    bool success = await _supervisorService.updateSupervisorById(supervisorToUpdate);

    if (success) {
      Supervisor newSupervisor = Supervisor(
        id: _supervisor!.id,
        name: supervisorToUpdate.name!,
        firstLastName: supervisorToUpdate.firstLastName!,
        secondLastName: supervisorToUpdate.secondLastName!,
        email: supervisorToUpdate.email!,
        phone: supervisorToUpdate.phone!,
        username: _supervisor!.username,
        userId: _supervisor!.userId,
      );
      updateSupervisor(newSupervisor);
    } else {
      throw Exception('Failed to update supervisor details');
    }
    notifyListeners();
    return success;
  }

  void clearSupervisor() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove(SharedPreferencesKey.SUPERVISOR_ID);
    prefs.remove(SharedPreferencesKey.SUPERVISOR);
    prefs.remove(SharedPreferencesKey.TOKEN);
    _supervisor = null;
    notifyListeners();
  }
}
