class Dispute {
  final String id;
  final String ticketNumber;
  final String title;
  final String description;
  final String status; // 'submitted', 'in_progress', 'under_review', 'resolved'
  final DateTime createdAt;
  final String? serviceType;
  final String? disputeType;

  const Dispute({
    required this.id,
    required this.ticketNumber,
    required this.title,
    required this.description,
    required this.status,
    required this.createdAt,
    this.serviceType,
    this.disputeType,
  });
}
