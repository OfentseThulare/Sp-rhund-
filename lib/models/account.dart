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

  double get totalBalance =>
      services.fold(0, (sum, s) => sum + s.currentBalance);
}

class AccountService {
  final String id;
  final ServiceType serviceType;
  final double currentBalance;
  final DateTime? dueDate;
  final ServiceStatus status;

  const AccountService({
    required this.id,
    required this.serviceType,
    required this.currentBalance,
    this.dueDate,
    required this.status,
  });
}

enum ServiceType {
  water,
  electricity,
  ratesAndTaxes,
  waste,
  sanitation,
  refuse;

  String get displayName {
    switch (this) {
      case ServiceType.water:
        return 'Water';
      case ServiceType.electricity:
        return 'Electricity';
      case ServiceType.ratesAndTaxes:
        return 'Rates and Taxes';
      case ServiceType.waste:
        return 'Waste';
      case ServiceType.sanitation:
        return 'Sanitation';
      case ServiceType.refuse:
        return 'Refuse Removal';
    }
  }
}

enum ServiceStatus {
  current,
  dueSoon,
  overdue,
  paid;

  String get displayName {
    switch (this) {
      case ServiceStatus.current:
        return 'Current';
      case ServiceStatus.dueSoon:
        return 'Due Soon';
      case ServiceStatus.overdue:
        return 'Overdue';
      case ServiceStatus.paid:
        return 'Paid';
    }
  }
}
