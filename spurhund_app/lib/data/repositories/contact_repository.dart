import '../../models/contact.dart';
import '../services/mock_contact_service.dart';

class ContactRepository {
  final MockContactService _service;

  ContactRepository(this._service);

  Future<List<Contact>> getContacts() async {
    return await _service.fetchContacts();
  }

  Future<Councillor> getCouncillor() async {
    return await _service.fetchCouncillor();
  }
}
