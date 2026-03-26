import '../../../models/user.dart';

abstract class IUserRepository {
  AppUser getUser();
}
