import 'package:flutter/foundation.dart';
import '../data/repositories/interfaces/i_user_repository.dart';
import '../data/repositories/user_repository.dart';
import '../models/user.dart';
import '../data/mock/provinces_and_municipalities.dart';
import '../models/municipality.dart';

class AuthViewModel extends ChangeNotifier {
  final IUserRepository _userRepo;

  AppUser? _user;
  String? _selectedProvince;
  String? _selectedMunicipality;
  bool _isAuthenticated = false;
  String? _errorMessage;

  AuthViewModel({IUserRepository? userRepo})
      : _userRepo = userRepo ?? UserRepository();

  AppUser? get user => _user;
  bool get isAuthenticated => _isAuthenticated;
  String? get selectedProvince => _selectedProvince;
  String? get selectedMunicipality => _selectedMunicipality;
  String? get errorMessage => _errorMessage;
  bool get hasError => _errorMessage != null;

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

  void clearError() {
    _errorMessage = null;
    notifyListeners();
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
    try {
      _errorMessage = null;
      _user = _userRepo.getUser();
      _isAuthenticated = true;
      notifyListeners();
    } catch (e) {
      _errorMessage = 'Failed to sign in. Please try again.';
      notifyListeners();
    }
  }

  void completeOnboarding() {
    try {
      _errorMessage = null;
      _user = _userRepo.getUser();
      _isAuthenticated = true;
      notifyListeners();
    } catch (e) {
      _errorMessage = 'Failed to complete onboarding. Please try again.';
      notifyListeners();
    }
  }

  void signOut() {
    _user = null;
    _isAuthenticated = false;
    _selectedProvince = null;
    _selectedMunicipality = null;
    _errorMessage = null;
    notifyListeners();
  }
}
