class ServiceAlert {
  final String id;
  final AlertType alertType;
  final String title;
  final String area;
  final String? description;
  final AlertSeverity severity;
  final DateTime? startTime;
  final DateTime? endTime;
  final DateTime createdAt;

  const ServiceAlert({
    required this.id,
    required this.alertType,
    required this.title,
    required this.area,
    this.description,
    required this.severity,
    this.startTime,
    this.endTime,
    required this.createdAt,
  });
}

enum AlertType {
  outage,
  maintenance,
  resolved,
  loadshedding,
  info;

  String get displayName {
    switch (this) {
      case AlertType.outage:
        return 'OUTAGE';
      case AlertType.maintenance:
        return 'MAINTENANCE';
      case AlertType.resolved:
        return 'RESOLVED';
      case AlertType.loadshedding:
        return 'LOADSHEDDING';
      case AlertType.info:
        return 'INFO';
    }
  }
}

enum AlertSeverity {
  critical,
  warning,
  info,
  resolved;
}
