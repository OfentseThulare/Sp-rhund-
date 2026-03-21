class Contact {
  final String id;
  final String name;
  final String? role;
  final String? department;
  final String? phone;
  final String? email;
  final ContactType type;

  const Contact({
    required this.id,
    required this.name,
    this.role,
    this.department,
    this.phone,
    this.email,
    required this.type,
  });
}

enum ContactType {
  councillor,
  department,
  emergency;
}
