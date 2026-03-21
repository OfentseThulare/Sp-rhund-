import 'package:flutter/foundation.dart';
import '../models/user.dart';
import '../data/repositories/user_repository.dart';

class UserViewModel extends ChangeNotifier {
  final UserRepository _repository;
  
  UserProfile? _userProfile;
  bool _isLoading = false;
  
  UserViewModel(this._repository);
  
  UserProfile? get userProfile => _userProfile;
  bool get isLoading => _isLoading;
  
  Future<void> loadUserProfile() async {
    _isLoading = true;
    notifyListeners();
    
    _userProfile = await _repository.getUserProfile();
    
    _isLoading = false;
    notifyListeners();
  }
}
