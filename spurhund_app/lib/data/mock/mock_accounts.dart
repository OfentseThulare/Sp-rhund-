import '../../models/account.dart';

final List<Account> mockAccounts = [
  Account(
    id: "acc_1",
    accountNumber: "5006378452",
    municipality: "City of Tshwane",
    propertyType: "Sectional Title",
    address: "703, Eifel Towers, 254X Jorissen Street, Sunnyside, 0002",
    unitNumber: "S0023",
    services: [
      AccountService(
        id: "svc_1",
        serviceType: "electricity",
        currentBalance: 1842.30,
        dueDate: DateTime.now().add(const Duration(days: 5)),
        status: "due_soon",
      ),
      AccountService(
        id: "svc_2",
        serviceType: "water",
        currentBalance: 1256.00,
        dueDate: DateTime.now().add(const Duration(days: 5)),
        status: "due_soon",
      ),
      AccountService(
        id: "svc_3",
        serviceType: "rates",
        currentBalance: 1234.20,
        status: "current",
      ),
      AccountService(
        id: "svc_4",
        serviceType: "waste",
        currentBalance: 500.00,
        dueDate: DateTime.now().add(const Duration(days: 5)),
        status: "due_soon",
      ),
    ]
  ),
];
