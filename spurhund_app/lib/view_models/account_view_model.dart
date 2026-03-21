import 'package:flutter/foundation.dart';
import '../models/account.dart';
import '../data/repositories/account_repository.dart';

class AccountViewModel extends ChangeNotifier {
  final AccountRepository _repository;
  
  List<Account> _accounts = [];
  bool _isLoading = false;
  
  AccountViewModel(this._repository);
  
  List<Account> get accounts => _accounts;
  bool get isLoading => _isLoading;
  
  Future<void> loadAccounts() async {
    _isLoading = true;
    notifyListeners();
    
    _accounts = await _repository.getAccounts();
    
    _isLoading = false;
    notifyListeners();
  }
}
