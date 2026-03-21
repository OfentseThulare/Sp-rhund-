import '../../models/service_alert.dart';
import '../mock/mock_status.dart';

class MockStatusService {
  Future<List<ServiceAlert>> fetchAlerts() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return mockAlerts;
  }
}
