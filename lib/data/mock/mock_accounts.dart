import '../../models/account.dart';

final mockAccounts = [
  Account(
    id: 'acc-001',
    accountNumber: '5006378452',
    municipality: 'City of Tshwane',
    propertyType: 'Sectional Title',
    address: '703, Eifel Towers, 254X Jorissen Street, Sunnyside, 0002',
    unitNumber: 'S0023',
    standNumber: '00152',
    services: [
      AccountService(
        id: 'svc-001',
        serviceType: ServiceType.electricity,
        currentBalance: 1842.30,
        dueDate: DateTime(2026, 3, 15),
        status: ServiceStatus.dueSoon,
      ),
      AccountService(
        id: 'svc-002',
        serviceType: ServiceType.water,
        currentBalance: 1256.00,
        dueDate: DateTime(2026, 3, 15),
        status: ServiceStatus.dueSoon,
      ),
      AccountService(
        id: 'svc-003',
        serviceType: ServiceType.ratesAndTaxes,
        currentBalance: 1234.20,
        dueDate: DateTime(2026, 3, 31),
        status: ServiceStatus.current,
      ),
      AccountService(
        id: 'svc-004',
        serviceType: ServiceType.waste,
        currentBalance: 500.00,
        dueDate: DateTime(2026, 3, 15),
        status: ServiceStatus.dueSoon,
      ),
    ],
  ),
];
