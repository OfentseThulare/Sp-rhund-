import '../../models/contact.dart';

final Councillor mockCouncillor = Councillor(
  id: "councillor_1",
  name: "Cllr. N. Mokoena",
  ward: "Ward 80",
  phoneNumber: "012 345 6789",
  email: "n.mokoena@tshwane.gov.za",
);

final List<Contact> mockContacts = [
  Contact(
    id: "contact_1",
    departmentName: "Water and Sanitation",
    phoneNumber: "012 358 9999",
    category: "Emergency",
    iconKey: "water_drop",
  ),
  Contact(
    id: "contact_2",
    departmentName: "Electricity",
    phoneNumber: "012 358 1111",
    category: "Emergency",
    iconKey: "bolt",
  ),
  Contact(
    id: "contact_3",
    departmentName: "Rates and Taxes",
    phoneNumber: "012 358 0000",
    category: "Billing",
    iconKey: "receipt",
  ),
  Contact(
    id: "contact_4",
    departmentName: "Waste Management",
    phoneNumber: "012 358 2222",
    category: "Maintenance",
    iconKey: "delete",
  ),
];
