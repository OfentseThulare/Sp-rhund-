import 'package:flutter/foundation.dart';
import '../models/bill.dart';
import '../data/repositories/bill_repository.dart';

class BillViewModel extends ChangeNotifier {
  final BillRepository _repository;
  
  List<Bill> _bills = [];
  bool _isLoading = false;
  
  BillViewModel(this._repository);
  
  List<Bill> get bills => _bills;
  bool get isLoading => _isLoading;
  
  Future<void> loadBills(String accountId) async {
    _isLoading = true;
    notifyListeners();
    
    _bills = await _repository.getBillsForAccount(accountId);
    
    _isLoading = false;
    notifyListeners();
  }
}
