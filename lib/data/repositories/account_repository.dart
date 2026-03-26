import '../../models/account.dart';
import '../mock/mock_accounts.dart';
import 'interfaces/i_account_repository.dart';

class AccountRepository implements IAccountRepository {
  @override
  List<Account> getAccounts() => List.unmodifiable(mockAccounts);

  @override
  Account? getAccountById(String id) {
    try {
      return mockAccounts.firstWhere((a) => a.id == id);
    } catch (_) {
      return null;
    }
  }

  @override
  double getTotalBalance() =>
      mockAccounts.fold(0, (sum, a) => sum + a.totalBalance);

  @override
  DateTime? getNextDueDate() {
    final allServices = mockAccounts.expand((a) => a.services).toList();
    allServices.sort((a, b) {
      if (a.dueDate == null) return 1;
      if (b.dueDate == null) return -1;
      return a.dueDate!.compareTo(b.dueDate!);
    });
    return allServices.isNotEmpty ? allServices.first.dueDate : null;
  }
}
