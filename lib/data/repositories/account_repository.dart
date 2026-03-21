import '../../models/account.dart';
import '../mock/mock_accounts.dart';

class AccountRepository {
  List<Account> getAccounts() => List.unmodifiable(mockAccounts);

  Account? getAccountById(String id) {
    try {
      return mockAccounts.firstWhere((a) => a.id == id);
    } catch (_) {
      return null;
    }
  }

  double getTotalBalance() =>
      mockAccounts.fold(0, (sum, a) => sum + a.totalBalance);

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
