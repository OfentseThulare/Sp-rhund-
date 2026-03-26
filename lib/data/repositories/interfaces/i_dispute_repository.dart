import '../../../models/dispute.dart';

abstract class IDisputeRepository {
  List<Dispute> getDisputes();
  Dispute? getDisputeById(String id);
  int get openCount;
}
