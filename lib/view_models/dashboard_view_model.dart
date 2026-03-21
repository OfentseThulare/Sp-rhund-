import 'package:flutter/foundation.dart';
import '../data/repositories/account_repository.dart';
import '../data/repositories/notification_repository.dart';
import '../data/repositories/status_repository.dart';
import '../models/account.dart';
import '../models/notification_item.dart';
import '../models/service_status.dart';

class DashboardViewModel extends ChangeNotifier {
  final AccountRepository _accountRepo;
  final NotificationRepository _notificationRepo;
  final StatusRepository _statusRepo;

  List<Account> _accounts = [];
  double _totalBalance = 0;
  DateTime? _nextDueDate;
  int _unreadNotifications = 0;
  List<ServiceAlert> _recentAlerts = [];

  DashboardViewModel({
    AccountRepository? accountRepo,
    NotificationRepository? notificationRepo,
    StatusRepository? statusRepo,
  })  : _accountRepo = accountRepo ?? AccountRepository(),
        _notificationRepo = notificationRepo ?? NotificationRepository(),
        _statusRepo = statusRepo ?? StatusRepository() {
    loadData();
  }

  List<Account> get accounts => _accounts;
  double get totalBalance => _totalBalance;
  DateTime? get nextDueDate => _nextDueDate;
  int get unreadNotifications => _unreadNotifications;
  List<ServiceAlert> get recentAlerts => _recentAlerts;

  List<AccountService> get allServices =>
      _accounts.expand((a) => a.services).toList();

  void loadData() {
    _accounts = _accountRepo.getAccounts();
    _totalBalance = _accountRepo.getTotalBalance();
    _nextDueDate = _accountRepo.getNextDueDate();
    _unreadNotifications = _notificationRepo.unreadCount;
    _recentAlerts = _statusRepo.getAlerts().take(1).toList();
    notifyListeners();
  }

  Future<void> refresh() async {
    await Future.delayed(const Duration(milliseconds: 800));
    loadData();
  }
}
