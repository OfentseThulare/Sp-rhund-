import '../../models/dispute.dart';

final List<Dispute> mockDisputes = [
  Dispute(
    id: "disp_1",
    ticketNumber: "#1042",
    title: "Incorrect water meter reading",
    description: "The meter reading on my latest bill does not match the actual meter.",
    status: "in_progress",
    createdAt: DateTime(2026, 2, 18),
    serviceType: "water",
  ),
  Dispute(
    id: "disp_2",
    ticketNumber: "#1038",
    title: "Billing discrepancy on rates",
    description: "Rates increased by 20% without prior notice.",
    status: "under_review",
    createdAt: DateTime(2026, 2, 10),
    serviceType: "rates",
  ),
  Dispute(
    id: "disp_3",
    ticketNumber: "#1031",
    title: "Double charge on electricity",
    description: "I was billed twice for electricity in January.",
    status: "resolved",
    createdAt: DateTime(2026, 2, 5),
    serviceType: "electricity",
  ),
];
