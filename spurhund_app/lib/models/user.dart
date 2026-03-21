class UserProfile {
  final String id;
  final String fullName;
  final String email;
  final String phone;
  final String province;
  final String municipality;
  final String propertyType;
  final String? avatarInitials;

  const UserProfile({
    required this.id,
    required this.fullName,
    required this.email,
    required this.phone,
    required this.province,
    required this.municipality,
    required this.propertyType,
    this.avatarInitials,
  });
}
