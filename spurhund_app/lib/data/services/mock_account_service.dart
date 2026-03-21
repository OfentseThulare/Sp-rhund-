import '../../models/account.dart';
import '../mock/mock_accounts.dart';

class MockAccountService {
  Future<List<Account>> fetchAccounts() async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 500));
    return mockAccounts;
  }
}
