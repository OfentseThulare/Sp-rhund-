import '../../models/dispute.dart';
import '../services/mock_dispute_service.dart';

class DisputeRepository {
  final MockDisputeService _service;

  DisputeRepository(this._service);

  Future<List<Dispute>> getDisputes() async {
    return await _service.fetchDisputes();
  }
}
