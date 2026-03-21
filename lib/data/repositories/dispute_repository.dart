import '../../models/dispute.dart';
import '../mock/mock_disputes.dart';

class DisputeRepository {
  List<Dispute> getDisputes() => List.unmodifiable(mockDisputes);

  Dispute? getDisputeById(String id) {
    try {
      return mockDisputes.firstWhere((d) => d.id == id);
    } catch (_) {
      return null;
    }
  }

  int get openCount =>
      mockDisputes.where((d) => d.status != DisputeStatus.resolved).length;
}
