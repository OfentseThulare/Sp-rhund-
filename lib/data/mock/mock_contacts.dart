import '../../models/contact.dart';

final mockContacts = [
  // Councillor
  const Contact(
    id: 'contact-001',
    name: 'Cllr. N. Mokoena',
    role: 'Ward 80, Sunnyside',
    phone: '+27 12 358 4920',
    email: 'n.mokoena@tshwane.gov.za',
    type: ContactType.councillor,
  ),

  // Departments
  const Contact(
    id: 'contact-002',
    name: 'Water and Sanitation',
    department: 'Water and Sanitation',
    phone: '+27 12 358 0911',
    email: 'water@tshwane.gov.za',
    type: ContactType.department,
  ),
  const Contact(
    id: 'contact-003',
    name: 'Electricity',
    department: 'Electricity',
    phone: '+27 12 358 9999',
    email: 'electricity@tshwane.gov.za',
    type: ContactType.department,
  ),
  const Contact(
    id: 'contact-004',
    name: 'Rates and Taxes',
    department: 'Rates and Taxes',
    phone: '+27 12 358 4848',
    email: 'rates@tshwane.gov.za',
    type: ContactType.department,
  ),
  const Contact(
    id: 'contact-005',
    name: 'Waste Management',
    department: 'Waste Management',
    phone: '+27 12 358 4636',
    email: 'waste@tshwane.gov.za',
    type: ContactType.department,
  ),

  // Emergency
  const Contact(
    id: 'contact-006',
    name: 'Fire Department',
    phone: '10111',
    type: ContactType.emergency,
  ),
  const Contact(
    id: 'contact-007',
    name: 'Ambulance',
    phone: '10177',
    type: ContactType.emergency,
  ),
];
