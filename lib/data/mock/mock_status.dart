import '../../models/service_status.dart';

final mockAlerts = [
  ServiceAlert(
    id: 'alert-001',
    alertType: AlertType.outage,
    title: 'Electricity supply interrupted',
    area: 'Sunnyside, Block C to F',
    description: 'Unplanned power outage affecting Sunnyside Block C to F. '
        'Technicians have been dispatched.',
    severity: AlertSeverity.critical,
    startTime: DateTime(2026, 3, 20, 6, 30),
    createdAt: DateTime(2026, 3, 20, 6, 30),
  ),
  ServiceAlert(
    id: 'alert-002',
    alertType: AlertType.maintenance,
    title: 'Scheduled water maintenance',
    area: 'Arcadia, Sunnyside',
    description: 'Planned maintenance on the water main along Pretorius Street. '
        'Water supply will be interrupted.',
    severity: AlertSeverity.warning,
    startTime: DateTime(2026, 3, 3, 8, 0),
    endTime: DateTime(2026, 3, 3, 16, 0),
    createdAt: DateTime(2026, 3, 1),
  ),
  ServiceAlert(
    id: 'alert-003',
    alertType: AlertType.resolved,
    title: 'Sewer blockage cleared',
    area: 'Hatfield',
    description: 'The sewer blockage on Burnett Street has been cleared. '
        'Normal service has resumed.',
    severity: AlertSeverity.resolved,
    endTime: DateTime(2026, 3, 20, 14, 0),
    createdAt: DateTime(2026, 3, 20, 14, 0),
  ),
  ServiceAlert(
    id: 'alert-004',
    alertType: AlertType.loadshedding,
    title: 'Stage 2 Load Shedding',
    area: 'National',
    description: 'Eskom has implemented Stage 2 load shedding. '
        'Check your area schedule for affected times.',
    severity: AlertSeverity.warning,
    startTime: DateTime(2026, 3, 20, 14, 0),
    endTime: DateTime(2026, 3, 20, 16, 30),
    createdAt: DateTime(2026, 3, 20, 12, 0),
  ),
  ServiceAlert(
    id: 'alert-005',
    alertType: AlertType.info,
    title: 'Meter reading schedule updated',
    area: 'Sunnyside Ward 80',
    description: 'The meter reading schedule for Ward 80 has been updated. '
        'Readings will take place from 25 to 28 March.',
    severity: AlertSeverity.info,
    createdAt: DateTime(2026, 3, 20, 9, 0),
  ),
];
