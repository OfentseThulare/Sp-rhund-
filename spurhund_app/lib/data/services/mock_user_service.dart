import '../../models/user.dart';

class MockUserService {
  Future<UserProfile> fetchUserProfile() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return const UserProfile(
      id: "user_1",
      fullName: "Makokotlela L.",
      email: "lionel@email.co.za",
      phone: "+27 12 345 6789",
      province: "Gauteng",
      municipality: "City of Tshwane",
      propertyType: "Sectional Title",
      avatarInitials: "ML",
    );
  }
}
