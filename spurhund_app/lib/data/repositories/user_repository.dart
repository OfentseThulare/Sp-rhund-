import '../../models/user.dart';
import '../services/mock_user_service.dart';

class UserRepository {
  final MockUserService _service;

  UserRepository(this._service);

  Future<UserProfile> getUserProfile() async {
    return await _service.fetchUserProfile();
  }
}
