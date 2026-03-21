import 'package:flutter/foundation.dart';
import '../models/service_alert.dart';
import '../data/repositories/status_repository.dart';

class StatusViewModel extends ChangeNotifier {
  final StatusRepository _repository;
  
  List<ServiceAlert> _alerts = [];
  bool _isLoading = false;
  
  StatusViewModel(this._repository);
  
  List<ServiceAlert> get alerts => _alerts;
  bool get isLoading => _isLoading;
  
  Future<void> loadAlerts() async {
    _isLoading = true;
    notifyListeners();
    
    _alerts = await _repository.getAlerts();
    
    _isLoading = false;
    notifyListeners();
  }
}
