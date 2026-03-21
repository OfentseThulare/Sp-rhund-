import '../../models/service_alert.dart';
import '../services/mock_status_service.dart';

class StatusRepository {
  final MockStatusService _service;

  StatusRepository(this._service);

  Future<List<ServiceAlert>> getAlerts() async {
    return await _service.fetchAlerts();
  }
}
