import 'package:flutter/foundation.dart';
import '../models/dispute.dart';
import '../data/repositories/dispute_repository.dart';

class DisputeViewModel extends ChangeNotifier {
  final DisputeRepository _repository;
  
  List<Dispute> _disputes = [];
  bool _isLoading = false;
  
  DisputeViewModel(this._repository);
  
  List<Dispute> get disputes => _disputes;
  bool get isLoading => _isLoading;
  
  Future<void> loadDisputes() async {
    _isLoading = true;
    notifyListeners();
    
    _disputes = await _repository.getDisputes();
    
    _isLoading = false;
    notifyListeners();
  }
}
