import '../../models/user.dart';
import '../mock/mock_user.dart';

class UserRepository {
  AppUser getUser() => mockUser;
}
