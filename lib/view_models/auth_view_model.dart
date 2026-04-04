import 'package:flutter/foundation.dart';
import '../data/mock/mock_user.dart';
import '../models/user.dart';
import '../data/mock/provinces_and_municipalities.dart';
import '../models/municipality.dart';

class AuthViewModel extends ChangeNotifier {
  AppUser? _user;
  String? _selectedProvince;
  String? _selectedMunicipality;
  bool _isAuthenticated = false;

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

  void signIn({String? email, String? name}) {
    _user = mockUser.copyWith(
      email: email ?? mockUser.email,
      fullName: name ?? mockUser.fullName,
    );
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
