import 'package:flutter/foundation.dart';
import '../data/repositories/user_repository.dart';
import '../models/user.dart';
import '../data/mock/provinces_and_municipalities.dart';
import '../models/municipality.dart';

class AuthViewModel extends ChangeNotifier {
  final UserRepository _userRepo;

  AppUser? _user;
  String? _selectedProvince;
  String? _selectedMunicipality;
  bool _isAuthenticated = false;

  AuthViewModel({UserRepository? userRepo})
      : _userRepo = userRepo ?? UserRepository();

  AppUser? get user => _user;
  bool get isAuthenticated => _isAuthenticated;
  String? get selectedProvince => _selectedProvince;
  String? get selectedMunicipality => _selectedMunicipality;

  List<Province> get provinces => saProvinces;

  List<String> get availableMunicipalities {
    if (_selectedProvince == null) return [];
    try {
      return saProvinces
          .firstWhere((p) => p.name == _selectedProvince)
          .municipalities;
    } catch (_) {
      return [];
    }
  }

  void selectProvince(String province) {
    _selectedProvince = province;
    _selectedMunicipality = null;
    notifyListeners();
  }

  void selectMunicipality(String municipality) {
    _selectedMunicipality = municipality;
    notifyListeners();
  }

  void signIn() {
    _user = _userRepo.getUser();
    _isAuthenticated = true;
    notifyListeners();
  }

  void completeOnboarding() {
    _user = _userRepo.getUser();
    _isAuthenticated = true;
    notifyListeners();
  }

  void signOut() {
    _user = null;
    _isAuthenticated = false;
    _selectedProvince = null;
    _selectedMunicipality = null;
    notifyListeners();
  }
}
