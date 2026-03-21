import 'package:flutter/foundation.dart';
import '../data/repositories/bill_repository.dart';
import '../models/bill.dart';

class AccountsViewModel extends ChangeNotifier {
  final BillRepository _billRepo;

  List<Bill> _bills = [];
  String _activeFilter = 'All';

  AccountsViewModel({BillRepository? billRepo})
      : _billRepo = billRepo ?? BillRepository() {
    loadData();
  }

  List<Bill> get bills => _bills;
  String get activeFilter => _activeFilter;

  Bill? getBillById(String id) => _billRepo.getBillById(id);

  void setFilter(String filter) {
    _activeFilter = filter;
    if (filter == 'All') {
      _bills = _billRepo.getBills();
    } else {
      _bills = _billRepo.getBills(); // mock: no per-service filtering
    }
    notifyListeners();
  }

  void loadData() {
    _bills = _billRepo.getBills();
    notifyListeners();
  }

  Future<void> refresh() async {
    await Future.delayed(const Duration(milliseconds: 800));
    loadData();
  }
}
