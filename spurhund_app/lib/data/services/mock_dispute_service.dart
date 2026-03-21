import '../../models/dispute.dart';
import '../mock/mock_disputes.dart';

class MockDisputeService {
  Future<List<Dispute>> fetchDisputes() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return mockDisputes;
  }
}
