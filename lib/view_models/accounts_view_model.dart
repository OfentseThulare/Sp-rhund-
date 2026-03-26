import 'package:flutter/foundation.dart';
import '../data/repositories/interfaces/i_bill_repository.dart';
import '../data/repositories/bill_repository.dart';
import '../models/bill.dart';

class AccountsViewModel extends ChangeNotifier {
  final IBillRepository _billRepo;

  List<Bill> _bills = [];
  String _activeFilter = 'All';
  String? _errorMessage;

  AccountsViewModel({IBillRepository? billRepo})
      : _billRepo = billRepo ?? BillRepository() {
    loadData();
  }

  List<Bill> get bills => _bills;
  String get activeFilter => _activeFilter;
  String? get errorMessage => _errorMessage;
  bool get hasError => _errorMessage != null;

  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }

  Bill? getBillById(String id) => _billRepo.getBillById(id);

  void setFilter(String filter) {
    _activeFilter = filter;
    if (filter == 'All') {
      _bills = _billRepo.getBills();
    } else {
      _bills = _billRepo.getBills();
    }
    notifyListeners();
  }

  void loadData() {
    try {
      _errorMessage = null;
      _bills = _billRepo.getBills();
      notifyListeners();
    } catch (e) {
      _errorMessage = 'Failed to load bills. Pull to refresh.';
      notifyListeners();
    }
  }

  Future<void> refresh() async {
    try {
      _errorMessage = null;
      notifyListeners();
      await Future.delayed(const Duration(milliseconds: 800));
      _bills = _billRepo.getBills();
      notifyListeners();
    } catch (e) {
      _errorMessage = 'Failed to refresh bills. Pull to refresh.';
      notifyListeners();
    }
  }
}
