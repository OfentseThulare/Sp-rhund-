import '../../models/bill.dart';
import '../mock/mock_bills.dart';

class MockBillService {
  Future<List<Bill>> fetchBills(String accountId) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return mockBills.where((b) => b.accountId == accountId).toList();
  }
}
