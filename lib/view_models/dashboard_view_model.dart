import 'package:flutter/foundation.dart';
import '../data/repositories/interfaces/i_account_repository.dart';
import '../data/repositories/interfaces/i_notification_repository.dart';
import '../data/repositories/interfaces/i_status_repository.dart';
import '../data/repositories/account_repository.dart';
import '../data/repositories/notification_repository.dart';
import '../data/repositories/status_repository.dart';
import '../models/account.dart';
import '../models/service_status.dart';

class DashboardViewModel extends ChangeNotifier {
  final IAccountRepository _accountRepo;
  final INotificationRepository _notificationRepo;
  final IStatusRepository _statusRepo;

  List<Account> _accounts = [];
  double _totalBalance = 0;
  DateTime? _nextDueDate;
  int _unreadNotifications = 0;
  List<ServiceAlert> _recentAlerts = [];
  String? _errorMessage;

  DashboardViewModel({
    IAccountRepository? accountRepo,
    INotificationRepository? notificationRepo,
    IStatusRepository? statusRepo,
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
  String? get errorMessage => _errorMessage;
  bool get hasError => _errorMessage != null;

  List<AccountService> get allServices =>
      _accounts.expand((a) => a.services).toList();

  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }

  void loadData() {
    try {
      _errorMessage = null;
      _accounts = _accountRepo.getAccounts();
      _totalBalance = _accountRepo.getTotalBalance();
      _nextDueDate = _accountRepo.getNextDueDate();
      _unreadNotifications = _notificationRepo.unreadCount;
      _recentAlerts = _statusRepo.getAlerts().take(1).toList();
      notifyListeners();
    } catch (e) {
      _errorMessage = 'Failed to load dashboard. Pull to refresh.';
      notifyListeners();
    }
  }

  Future<void> refresh() async {
    try {
      _errorMessage = null;
      notifyListeners();
      await Future.delayed(const Duration(milliseconds: 800));
      _accounts = _accountRepo.getAccounts();
      _totalBalance = _accountRepo.getTotalBalance();
      _nextDueDate = _accountRepo.getNextDueDate();
      _unreadNotifications = _notificationRepo.unreadCount;
      _recentAlerts = _statusRepo.getAlerts().take(1).toList();
      notifyListeners();
    } catch (e) {
      _errorMessage = 'Failed to refresh dashboard. Pull to refresh.';
      notifyListeners();
    }
  }
}
