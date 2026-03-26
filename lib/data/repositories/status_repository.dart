import '../../models/service_status.dart';
import '../mock/mock_status.dart';
import 'interfaces/i_status_repository.dart';

class StatusRepository implements IStatusRepository {
  @override
  List<ServiceAlert> getAlerts() => List.unmodifiable(mockAlerts);

  @override
  List<ServiceAlert> getAlertsByType(AlertType type) =>
      mockAlerts.where((a) => a.alertType == type).toList();
}
