import '../../models/service_status.dart';
import '../mock/mock_status.dart';

class StatusRepository {
  List<ServiceAlert> getAlerts() => List.unmodifiable(mockAlerts);

  List<ServiceAlert> getAlertsByType(AlertType type) =>
      mockAlerts.where((a) => a.alertType == type).toList();
}
