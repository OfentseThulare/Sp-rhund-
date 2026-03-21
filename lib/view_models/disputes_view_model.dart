import 'package:flutter/foundation.dart';
import '../data/repositories/dispute_repository.dart';
import '../models/dispute.dart';

class DisputesViewModel extends ChangeNotifier {
  final DisputeRepository _repo;

  List<Dispute> _disputes = [];

  DisputesViewModel({DisputeRepository? repo})
      : _repo = repo ?? DisputeRepository() {
    loadData();
  }

  List<Dispute> get disputes => _disputes;
  int get openCount => _repo.openCount;

  Dispute? getById(String id) => _repo.getDisputeById(id);

  void loadData() {
    _disputes = _repo.getDisputes();
    notifyListeners();
  }

  Future<void> refresh() async {
    await Future.delayed(const Duration(milliseconds: 800));
    loadData();
  }
}
