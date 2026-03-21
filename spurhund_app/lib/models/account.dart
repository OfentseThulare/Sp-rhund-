class AccountService {
  final String id;
  final String serviceType;
  final double currentBalance;
  final DateTime? dueDate;
  final String status;

  const AccountService({
    required this.id,
    required this.serviceType,
    required this.currentBalance,
    this.dueDate,
    required this.status,
  });
}

class Account {
  final String id;
  final String accountNumber;
  final String municipality;
  final String propertyType;
  final String address;
  final String? unitNumber;
  final String? standNumber;
  final List<AccountService> services;

  const Account({
    required this.id,
    required this.accountNumber,
    required this.municipality,
    required this.propertyType,
    required this.address,
    this.unitNumber,
    this.standNumber,
    this.services = const [],
  });
  
  double get totalBalance => services.fold(0, (sum, service) => sum + service.currentBalance);
}
