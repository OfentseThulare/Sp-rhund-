import '../../models/account.dart';
import '../services/mock_account_service.dart';

class AccountRepository {
  final MockAccountService _service;

  AccountRepository(this._service);

  Future<List<Account>> getAccounts() async {
    return await _service.fetchAccounts();
  }
}
