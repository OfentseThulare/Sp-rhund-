import '../../models/user.dart';
import '../mock/mock_user.dart';
import 'interfaces/i_user_repository.dart';

class UserRepository implements IUserRepository {
  @override
  AppUser getUser() => mockUser;
}
