import '../../models/contact.dart';
import '../mock/mock_contacts.dart';
import 'interfaces/i_contact_repository.dart';

class ContactRepository implements IContactRepository {
  @override
  List<Contact> getContacts() => List.unmodifiable(mockContacts);

  @override
  List<Contact> getByType(ContactType type) =>
      mockContacts.where((c) => c.type == type).toList();

  @override
  List<Contact> search(String query) {
    final lower = query.toLowerCase();
    return mockContacts
        .where((c) =>
            c.name.toLowerCase().contains(lower) ||
            (c.department?.toLowerCase().contains(lower) ?? false))
        .toList();
  }
}
