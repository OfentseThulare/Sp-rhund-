import '../../models/contact.dart';
import '../mock/mock_contacts.dart';

class ContactRepository {
  List<Contact> getContacts() => List.unmodifiable(mockContacts);

  List<Contact> getByType(ContactType type) =>
      mockContacts.where((c) => c.type == type).toList();

  List<Contact> search(String query) {
    final lower = query.toLowerCase();
    return mockContacts
        .where((c) =>
            c.name.toLowerCase().contains(lower) ||
            (c.department?.toLowerCase().contains(lower) ?? false))
        .toList();
  }
}
