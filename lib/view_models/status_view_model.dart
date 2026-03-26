import 'package:flutter/foundation.dart';
import '../data/repositories/interfaces/i_status_repository.dart';
import '../data/repositories/status_repository.dart';
import '../models/service_status.dart';

class StatusViewModel extends ChangeNotifier {
  final IStatusRepository _repo;

  List<ServiceAlert> _alerts = [];
  String? _errorMessage;

  StatusViewModel({IStatusRepository? repo})
      : _repo = repo ?? StatusRepository() {
    loadData();
  }

  List<ServiceAlert> get alerts => _alerts;
  String? get errorMessage => _errorMessage;
  bool get hasError => _errorMessage != null;

  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }

  void loadData() {
    try {
      _errorMessage = null;
      _alerts = _repo.getAlerts();
      notifyListeners();
    } catch (e) {
      _errorMessage = 'Failed to load service status. Pull to refresh.';
      notifyListeners();
    }
  }

  Future<void> refresh() async {
    try {
      _errorMessage = null;
      notifyListeners();
      await Future.delayed(const Duration(milliseconds: 800));
      _alerts = _repo.getAlerts();
      notifyListeners();
    } catch (e) {
      _errorMessage = 'Failed to refresh service status. Pull to refresh.';
      notifyListeners();
    }
  }
}
