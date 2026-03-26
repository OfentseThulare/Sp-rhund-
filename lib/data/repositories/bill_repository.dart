import '../../models/bill.dart';
import '../mock/mock_bills.dart';
import 'interfaces/i_bill_repository.dart';

class BillRepository implements IBillRepository {
  @override
  List<Bill> getBills() => List.unmodifiable(mockBills);

  @override
  Bill? getBillById(String id) {
    try {
      return mockBills.firstWhere((b) => b.id == id);
    } catch (_) {
      return null;
    }
  }

  @override
  List<Bill> getBillsByStatus(BillStatus status) =>
      mockBills.where((b) => b.status == status).toList();
}
