import 'package:flutter/material.dart';
import '../../theme/colours.dart';
import '../../theme/typography.dart';

class ContactsScreen extends StatefulWidget {
  const ContactsScreen({super.key});

  @override
  State<ContactsScreen> createState() => _ContactsScreenState();
}

class _ContactsScreenState extends State<ContactsScreen> {
  final _searchController = TextEditingController();
  String _searchQuery = '';
  int _selectedCategory = 0;

  static const List<String> _categories = [
    'All',
    'Emergency',
    'Billing',
    'Technical',
    'General',
  ];

  static const List<_MockContact> _allContacts = [
    _MockContact(
      category: 'Emergency',
      name: 'Emergency Services',
      phone: '10177',
      email: null,
      hours: '24/7',
    ),
    _MockContact(
      category: 'Billing',
      name: 'Revenue & Billing',
      phone: '012 358 4911',
      email: 'revenue@tshwane.gov.za',
      hours: 'Mon to Fri, 07:30 to 16:00',
    ),
    _MockContact(
      category: 'Technical',
      name: 'Water & Sanitation',
      phone: '012 358 0911',
      email: 'water@tshwane.gov.za',
      hours: 'Mon to Fri, 07:30 to 16:00',
    ),
    _MockContact(
      category: 'Technical',
      name: 'Electricity Faults',
      phone: '012 358 9999',
      email: 'electricity@tshwane.gov.za',
      hours: '24/7',
    ),
    _MockContact(
      category: 'General',
      name: 'Customer Care Centre',
      phone: '012 358 9999',
      email: 'customercare@tshwane.gov.za',
      hours: 'Mon to Fri, 07:30 to 16:00',
    ),
    _MockContact(
      category: 'General',
      name: 'Tshwane Connect',
      phone: '012 358 4636',
      email: null,
      hours: 'Mon to Fri, 08:00 to 17:00',
    ),
  ];

  List<_MockContact> get _filteredContacts {
    var contacts = _allContacts.toList();

    if (_selectedCategory > 0) {
      final category = _categories[_selectedCategory];
      contacts = contacts.where((c) => c.category == category).toList();
    }

    if (_searchQuery.isNotEmpty) {
      final query = _searchQuery.toLowerCase();
      contacts = contacts.where((c) {
        return c.name.toLowerCase().contains(query) ||
            c.category.toLowerCase().contains(query) ||
            (c.phone?.toLowerCase().contains(query) ?? false) ||
            (c.email?.toLowerCase().contains(query) ?? false);
      }).toList();
    }

    return contacts;
  }

  @override
  void initState() {
    super.initState();
    _searchController.addListener(() {
      setState(() => _searchQuery = _searchController.text);
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final contacts = _filteredContacts;

    return Scaffold(
      backgroundColor: AppColours.voidBlack,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 16, 24, 0),
              child: Semantics(
                header: true,
                child: Text(
                  'Contacts',
                  style: AppTypography.headlineMedium,
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Search input
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Container(
                height: 48,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: AppColours.surface,
                  border: Border.all(color: AppColours.borderLight),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.search, size: 20, color: AppColours.textTertiary),
                    const SizedBox(width: 12),
                    Expanded(
                      child: TextField(
                        controller: _searchController,
                        style: AppTypography.bodyMedium,
                        decoration: InputDecoration(
                          hintText: 'Search contacts...',
                          hintStyle: AppTypography.bodyMedium.copyWith(
                            color: AppColours.textTertiary,
                          ),
                          border: InputBorder.none,
                          isDense: true,
                          contentPadding: EdgeInsets.zero,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Category filter chips
            SizedBox(
              height: 36,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Row(
                  children: List.generate(_categories.length, (index) {
                    final isActive = _selectedCategory == index;
                    return Padding(
                      padding: EdgeInsets.only(right: index < _categories.length - 1 ? 8 : 0),
                      child: Semantics(
                        button: true,
                        label: 'Filter ${_categories[index]} contacts',
                        child: GestureDetector(
                          onTap: () => setState(() => _selectedCategory = index),
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                          decoration: BoxDecoration(
                            color: isActive ? AppColours.primaryPurple : AppColours.surface,
                            borderRadius: BorderRadius.circular(100),
                            border: isActive
                                ? null
                                : Border.all(color: AppColours.borderLight),
                          ),
                          child: Text(
                            _categories[index],
                            style: AppTypography.labelLarge.copyWith(
                              fontSize: 13,
                              color: isActive
                                  ? AppColours.textPrimary
                                  : AppColours.textSecondary,
                            ),
                          ),
                        ),
                      ),
                      ),
                    );
                  }),
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Contact list
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                itemCount: contacts.length,
                itemBuilder: (context, index) {
                  final contact = contacts[index];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: AppColours.surface,
                        border: Border.all(color: AppColours.borderSubtle),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            contact.name,
                            style: AppTypography.amountMedium.copyWith(
                              fontSize: 15,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            contact.hours,
                            style: AppTypography.bodySmall.copyWith(
                              color: AppColours.textTertiary,
                            ),
                          ),
                          const SizedBox(height: 12),
                          Row(
                            children: [
                              if (contact.phone != null)
                                Semantics(
                                  button: true,
                                  label: 'Call ${contact.name}',
                                  child: _ActionChip(
                                    icon: Icons.phone_outlined,
                                    label: 'Call',
                                  ),
                                ),
                              if (contact.phone != null && contact.email != null)
                                const SizedBox(width: 8),
                              if (contact.email != null)
                                Semantics(
                                  button: true,
                                  label: 'Email ${contact.name}',
                                  child: _ActionChip(
                                    icon: Icons.email_outlined,
                                    label: 'Email',
                                  ),
                                ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ActionChip extends StatelessWidget {
  final IconData icon;
  final String label;

  const _ActionChip({
    required this.icon,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        border: Border.all(color: AppColours.primaryPurple),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: AppColours.primaryPurple),
          const SizedBox(width: 6),
          Text(
            label,
            style: AppTypography.labelLarge.copyWith(
              fontSize: 13,
              color: AppColours.primaryPurple,
            ),
          ),
        ],
      ),
    );
  }
}

class _MockContact {
  final String category;
  final String name;
  final String? phone;
  final String? email;
  final String hours;

  const _MockContact({
    required this.category,
    required this.name,
    required this.phone,
    required this.email,
    required this.hours,
  });
}
