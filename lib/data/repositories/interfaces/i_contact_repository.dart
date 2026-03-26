import '../../../models/contact.dart';

abstract class IContactRepository {
  List<Contact> getContacts();
  List<Contact> getByType(ContactType type);
  List<Contact> search(String query);
}
