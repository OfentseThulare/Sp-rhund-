import '../../../models/service_status.dart';

abstract class IStatusRepository {
  List<ServiceAlert> getAlerts();
  List<ServiceAlert> getAlertsByType(AlertType type);
}
