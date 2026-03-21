import '../../models/dispute.dart';

final mockDisputes = [
  Dispute(
    id: 'disp-001',
    ticketNumber: '#1042',
    title: 'Incorrect water meter reading',
    description:
        'The meter reading on my February 2026 statement does not match '
        'the actual reading on my water meter. The statement shows 4521 kL '
        'but the actual reading is 4102 kL.',
    serviceType: 'Water',
    disputeType: 'Meter Reading',
    status: DisputeStatus.inProgress,
    createdAt: DateTime(2026, 2, 18),
    updatedAt: DateTime(2026, 2, 20),
  ),
  Dispute(
    id: 'disp-002',
    ticketNumber: '#1038',
    title: 'Billing discrepancy on rates',
    description:
        'My property rates have increased by 40% from the previous month '
        'with no notification or explanation. Please review.',
    serviceType: 'Rates and Taxes',
    disputeType: 'Billing Error',
    status: DisputeStatus.underReview,
    createdAt: DateTime(2026, 2, 10),
    updatedAt: DateTime(2026, 2, 15),
  ),
  Dispute(
    id: 'disp-003',
    ticketNumber: '#1031',
    title: 'Double charge on electricity',
    description:
        'I was charged twice for electricity in October 2025. '
        'One charge appears to be a duplicate.',
    serviceType: 'Electricity',
    disputeType: 'Duplicate Charge',
    status: DisputeStatus.resolved,
    createdAt: DateTime(2026, 2, 5),
    updatedAt: DateTime(2026, 2, 12),
  ),
];
