import 'package:flutter/foundation.dart';
import '../models/notification_item.dart';
import '../data/repositories/notification_repository.dart';

class NotificationViewModel extends ChangeNotifier {
  final NotificationRepository _repository;
  
  List<NotificationItem> _notifications = [];
  bool _isLoading = false;
  
  NotificationViewModel(this._repository);
  
  List<NotificationItem> get notifications => _notifications;
  bool get isLoading => _isLoading;
  
  Future<void> loadNotifications() async {
    _isLoading = true;
    notifyListeners();
    
    _notifications = await _repository.getNotifications();
    
    _isLoading = false;
    notifyListeners();
  }
}
