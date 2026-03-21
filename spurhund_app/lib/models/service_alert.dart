class ServiceAlert {
  final String id;
  final String alertType; // outage, maintenance, resolved, loadshedding, info
  final String title;
  final String area;
  final String description;
  final String severity; // critical, warning, info, resolved
  final DateTime startTime;
  final DateTime? endTime;
  final DateTime createdAt;

  const ServiceAlert({
    required this.id,
    required this.alertType,
    required this.title,
    required this.area,
    required this.description,
    required this.severity,
    required this.startTime,
    this.endTime,
    required this.createdAt,
  });
}
