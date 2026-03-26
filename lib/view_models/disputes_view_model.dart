import 'package:flutter/foundation.dart';
import '../data/repositories/interfaces/i_dispute_repository.dart';
import '../data/repositories/dispute_repository.dart';
import '../models/dispute.dart';

class DisputesViewModel extends ChangeNotifier {
  final IDisputeRepository _repo;

  List<Dispute> _disputes = [];
  String? _errorMessage;

  DisputesViewModel({IDisputeRepository? repo})
      : _repo = repo ?? DisputeRepository() {
    loadData();
  }

  List<Dispute> get disputes => _disputes;
  int get openCount => _repo.openCount;
  String? get errorMessage => _errorMessage;
  bool get hasError => _errorMessage != null;

  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }

  Dispute? getById(String id) => _repo.getDisputeById(id);

  void loadData() {
    try {
      _errorMessage = null;
      _disputes = _repo.getDisputes();
      notifyListeners();
    } catch (e) {
      _errorMessage = 'Failed to load disputes. Pull to refresh.';
      notifyListeners();
    }
  }

  Future<void> refresh() async {
    try {
      _errorMessage = null;
      notifyListeners();
      await Future.delayed(const Duration(milliseconds: 800));
      _disputes = _repo.getDisputes();
      notifyListeners();
    } catch (e) {
      _errorMessage = 'Failed to refresh disputes. Pull to refresh.';
      notifyListeners();
    }
  }
}
