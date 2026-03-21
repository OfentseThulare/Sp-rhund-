import 'package:flutter/foundation.dart';
import '../models/contact.dart';
import '../data/repositories/contact_repository.dart';

class ContactViewModel extends ChangeNotifier {
  final ContactRepository _repository;
  
  List<Contact> _contacts = [];
  Councillor? _councillor;
  bool _isLoading = false;
  
  ContactViewModel(this._repository);
  
  List<Contact> get contacts => _contacts;
  Councillor? get councillor => _councillor;
  bool get isLoading => _isLoading;
  
  Future<void> loadContacts() async {
    _isLoading = true;
    notifyListeners();
    
    final results = await Future.wait([
      _repository.getContacts(),
      _repository.getCouncillor(),
    ]);
    
    _contacts = results[0] as List<Contact>;
    _councillor = results[1] as Councillor;
    
    _isLoading = false;
    notifyListeners();
  }
}
