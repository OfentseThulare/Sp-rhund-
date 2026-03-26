import '../../../models/account.dart';

abstract class IAccountRepository {
  List<Account> getAccounts();
  Account? getAccountById(String id);
  double getTotalBalance();
  DateTime? getNextDueDate();
}
