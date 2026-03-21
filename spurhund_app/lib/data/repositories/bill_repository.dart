import '../../models/bill.dart';
import '../services/mock_bill_service.dart';

class BillRepository {
  final MockBillService _service;

  BillRepository(this._service);

  Future<List<Bill>> getBillsForAccount(String accountId) async {
    return await _service.fetchBills(accountId);
  }
}
