import '../../models/bill.dart';
import '../mock/mock_bills.dart';

class BillRepository {
  List<Bill> getBills() => List.unmodifiable(mockBills);

  Bill? getBillById(String id) {
    try {
      return mockBills.firstWhere((b) => b.id == id);
    } catch (_) {
      return null;
    }
  }

  List<Bill> getBillsByStatus(BillStatus status) =>
      mockBills.where((b) => b.status == status).toList();
}
