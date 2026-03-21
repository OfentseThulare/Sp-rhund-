import '../../models/bill.dart';

final List<Bill> mockBills = [
  Bill(
    id: "bill_1",
    accountId: "acc_1",
    period: "February 2026",
    totalAmount: 4832.50,
    status: "unpaid",
    issuedDate: DateTime(2026, 2, 20),
    dueDate: DateTime(2026, 3, 15),
    serviceCount: 4,
  ),
  Bill(
    id: "bill_2",
    accountId: "acc_1",
    period: "January 2026",
    totalAmount: 4156.20,
    status: "paid",
    issuedDate: DateTime(2026, 1, 20),
    dueDate: DateTime(2026, 2, 15),
    serviceCount: 4,
  ),
  Bill(
    id: "bill_3",
    accountId: "acc_1",
    period: "December 2025",
    totalAmount: 5021.80,
    status: "paid",
    issuedDate: DateTime(2025, 12, 20),
    dueDate: DateTime(2026, 1, 15),
    serviceCount: 4,
  ),
  Bill(
    id: "bill_4",
    accountId: "acc_1",
    period: "November 2025",
    totalAmount: 3890.00,
    status: "paid",
    issuedDate: DateTime(2025, 11, 20),
    dueDate: DateTime(2025, 12, 15),
    serviceCount: 4,
  ),
];
