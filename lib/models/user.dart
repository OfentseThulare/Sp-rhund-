class AppUser {
  final String id;
  final String fullName;
  final String email;
  final String phone;
  final String province;
  final String municipality;
  final String propertyType;
  final String initials;

  const AppUser({
    required this.id,
    required this.fullName,
    required this.email,
    required this.phone,
    required this.province,
    required this.municipality,
    required this.propertyType,
    String? initials,
  }) : initials = initials ?? '';

  AppUser copyWith({
    String? id,
    String? fullName,
    String? email,
    String? phone,
    String? province,
    String? municipality,
    String? propertyType,
  }) {
    return AppUser(
      id: id ?? this.id,
      fullName: fullName ?? this.fullName,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      province: province ?? this.province,
      municipality: municipality ?? this.municipality,
      propertyType: propertyType ?? this.propertyType,
      initials: (fullName ?? this.fullName)
          .split(' ')
          .map((w) => w.isNotEmpty ? w[0] : '')
          .take(2)
          .join()
          .toUpperCase(),
    );
  }
}
