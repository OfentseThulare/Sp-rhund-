import 'package:flutter/foundation.dart';
import '../data/repositories/status_repository.dart';
import '../models/service_status.dart';

class StatusViewModel extends ChangeNotifier {
  final StatusRepository _repo;

  List<ServiceAlert> _alerts = [];

  StatusViewModel({StatusRepository? repo})
      : _repo = repo ?? StatusRepository() {
    loadData();
  }

  List<ServiceAlert> get alerts => _alerts;

  void loadData() {
    _alerts = _repo.getAlerts();
    notifyListeners();
  }

  Future<void> refresh() async {
    await Future.delayed(const Duration(milliseconds: 800));
    loadData();
  }
}
