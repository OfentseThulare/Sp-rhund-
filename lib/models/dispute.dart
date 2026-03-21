class Dispute {
  final String id;
  final String ticketNumber;
  final String title;
  final String? description;
  final String? serviceType;
  final String? disputeType;
  final DisputeStatus status;
  final DateTime createdAt;
  final DateTime? updatedAt;

  const Dispute({
    required this.id,
    required this.ticketNumber,
    required this.title,
    this.description,
    this.serviceType,
    this.disputeType,
    required this.status,
    required this.createdAt,
    this.updatedAt,
  });
}

enum DisputeStatus {
  submitted,
  inProgress,
  underReview,
  resolved;

  String get displayName {
    switch (this) {
      case DisputeStatus.submitted:
        return 'Submitted';
      case DisputeStatus.inProgress:
        return 'In Progress';
      case DisputeStatus.underReview:
        return 'Under Review';
      case DisputeStatus.resolved:
        return 'Resolved';
    }
  }
}
