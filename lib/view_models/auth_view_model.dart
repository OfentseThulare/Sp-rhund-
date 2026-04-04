import 'dart:async';
import 'package:flutter/foundation.dart';
import '../services/auth_service.dart';
import '../services/supabase_service.dart';
import '../models/user.dart';
import '../data/mock/provinces_and_municipalities.dart';
import '../models/municipality.dart';

class AuthViewModel extends ChangeNotifier {
  AppUser? _user;
  String? _selectedProvince;
  String? _selectedMunicipality;
  bool _isAuthenticated = false;
  bool _needsEmailConfirmation = false;
  String? _errorMessage;
  StreamSubscription? _authSubscription;

  AuthViewModel() {
    _listenToAuthChanges();
    _checkExistingSession();
  }

  AppUser? get user => _user;
  bool get isAuthenticated => _isAuthenticated;
  String? get selectedProvince => _selectedProvince;
  String? get selectedMunicipality => _selectedMunicipality;
  String? get errorMessage => _errorMessage;
  bool get hasError => _errorMessage != null;
  bool get needsEmailConfirmation => _needsEmailConfirmation;

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

  void _listenToAuthChanges() {
    _authSubscription = SupabaseService.authStateChanges.listen((data) {
      final session = data.session;
      if (session != null) {
        _isAuthenticated = true;
        _loadProfile(session.user.id);
      } else {
        _isAuthenticated = false;
        _user = null;
      }
      notifyListeners();
    });
  }

  Future<void> _checkExistingSession() async {
    final currentUser = SupabaseService.currentUser;
    if (currentUser != null) {
      _isAuthenticated = true;
      await _loadProfile(currentUser.id);
      notifyListeners();
    }
  }

  Future<void> _loadProfile(String userId) async {
    final profile = await AuthService.getProfile(userId);
    if (profile != null) {
      _user = AppUser(
        id: userId,
        fullName: profile['full_name'] ?? '',
        email: profile['email'] ?? '',
        phone: profile['phone'] ?? '',
        province: profile['province'] ?? '',
        municipality: profile['municipality'] ?? '',
        propertyType: profile['property_type'] ?? '',
        initials: _getInitials(profile['full_name'] ?? ''),
      );
      notifyListeners();
    }
  }

  String _getInitials(String name) {
    if (name.isEmpty) return '';
    final parts = name.trim().split(' ');
    if (parts.length >= 2) {
      return '${parts.first[0]}${parts.last[0]}'.toUpperCase();
    }
    return parts.first[0].toUpperCase();
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

  Future<bool> signUpWithSupabase({
    required String email,
    required String password,
    String? fullName,
    String? phone,
  }) async {
    _errorMessage = null;
    _needsEmailConfirmation = false;
    notifyListeners();

    final result = await AuthService.signUp(
      email: email,
      password: password,
      fullName: fullName,
      phone: phone,
      province: _selectedProvince,
      municipality: _selectedMunicipality,
    );

    if (result.success) {
      _needsEmailConfirmation = result.needsEmailConfirmation;
      if (!result.needsEmailConfirmation) {
        _isAuthenticated = true;
        if (result.user != null) {
          await _loadProfile(result.user!.id);
        }
      }
      notifyListeners();
      return true;
    } else {
      _errorMessage = result.errorMessage;
      notifyListeners();
      return false;
    }
  }

  Future<bool> signInWithSupabase({
    required String email,
    required String password,
  }) async {
    _errorMessage = null;
    notifyListeners();

    final result = await AuthService.signIn(
      email: email,
      password: password,
    );

    if (result.success) {
      _isAuthenticated = true;
      if (result.user != null) {
        await _loadProfile(result.user!.id);
      }
      notifyListeners();
      return true;
    } else {
      _errorMessage = result.errorMessage;
      notifyListeners();
      return false;
    }
  }

  Future<void> signOut() async {
    await AuthService.signOut();
    _user = null;
    _isAuthenticated = false;
    _selectedProvince = null;
    _selectedMunicipality = null;
    _errorMessage = null;
    notifyListeners();
  }

  @override
  void dispose() {
    _authSubscription?.cancel();
    super.dispose();
  }
}
