import '../../models/contact.dart';
import '../mock/mock_contacts.dart';

class MockContactService {
  Future<List<Contact>> fetchContacts() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return mockContacts;
  }

  Future<Councillor> fetchCouncillor() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return mockCouncillor;
  }
}
