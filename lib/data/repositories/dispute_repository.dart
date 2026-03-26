import '../../models/dispute.dart';
import '../mock/mock_disputes.dart';
import 'interfaces/i_dispute_repository.dart';

class DisputeRepository implements IDisputeRepository {
  @override
  List<Dispute> getDisputes() => List.unmodifiable(mockDisputes);

  @override
  Dispute? getDisputeById(String id) {
    try {
      return mockDisputes.firstWhere((d) => d.id == id);
    } catch (_) {
      return null;
    }
  }

  @override
  int get openCount =>
      mockDisputes.where((d) => d.status != DisputeStatus.resolved).length;
}
