class Contact {
  final String id;
  final String departmentName;
  final String phoneNumber;
  final String? email;
  final String category; // Emergency, Billing, Maintenance, etc.
  final String iconKey; // mapping to material icons

  const Contact({
    required this.id,
    required this.departmentName,
    required this.phoneNumber,
    this.email,
    required this.category,
    required this.iconKey,
  });
}

class Councillor {
  final String id;
  final String name;
  final String ward;
  final String phoneNumber;
  final String email;

  const Councillor({
    required this.id,
    required this.name,
    required this.ward,
    required this.phoneNumber,
    required this.email,
  });
}
