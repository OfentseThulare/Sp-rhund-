import 'package:flutter/material.dart';
import '../../theme/colours.dart';
import '../../models/contact.dart';
import '../../data/repositories/contact_repository.dart';

class ContactsScreen extends StatefulWidget {
  const ContactsScreen({super.key});

  @override
  State<ContactsScreen> createState() => _ContactsScreenState();
}

class _ContactsScreenState extends State<ContactsScreen> {
  final _repo = ContactRepository();
  final _searchController = TextEditingController();
  List<Contact> _filtered = [];

  @override
  void initState() {
    super.initState();
    _filtered = _repo.getContacts();
    _searchController.addListener(_onSearch);
  }

  void _onSearch() {
    final query = _searchController.text;
    setState(() {
      _filtered = query.isEmpty ? _repo.getContacts() : _repo.search(query);
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final councillors = _filtered.where((c) => c.type == ContactType.councillor).toList();
    final departments = _filtered.where((c) => c.type == ContactType.department).toList();
    final emergency = _filtered.where((c) => c.type == ContactType.emergency).toList();

    return Scaffold(
      backgroundColor: AppColours.pureWhite,
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          children: [
            const SizedBox(height: 16),
            const Text(
              'Contacts',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w700,
                color: AppColours.nearBlack,
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search departments...',
                prefixIcon: const Icon(Icons.search, color: AppColours.slate),
                filled: true,
                fillColor: AppColours.cloudGrey,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 20),
            ...councillors.map((c) => Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: _CouncillorCard(contact: c),
                )),
            if (departments.isNotEmpty) ...[
              const SizedBox(height: 8),
              const Text(
                'Departments',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: AppColours.nearBlack),
              ),
              const SizedBox(height: 8),
              Container(
                decoration: BoxDecoration(
                  color: AppColours.pureWhite,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.04),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  children: departments.asMap().entries.map((entry) {
                    final i = entry.key;
                    final c = entry.value;
                    return Column(
                      children: [
                        ListTile(
                          title: Text(
                            c.name,
                            style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                          ),
                          subtitle: Text(c.phone ?? '', style: const TextStyle(fontSize: 13, color: AppColours.slate)),
                          trailing: const Icon(Icons.chevron_right, color: AppColours.fog),
                        ),
                        if (i < departments.length - 1)
                          const Divider(height: 0, indent: 16, endIndent: 16),
                      ],
                    );
                  }).toList(),
                ),
              ),
            ],
            if (emergency.isNotEmpty) ...[
              const SizedBox(height: 24),
              const Text(
                'Emergency Numbers',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: AppColours.nearBlack),
              ),
              const SizedBox(height: 8),
              Container(
                decoration: BoxDecoration(
                  color: AppColours.pureWhite,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.04),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  children: emergency.asMap().entries.map((entry) {
                    final i = entry.key;
                    final c = entry.value;
                    return Column(
                      children: [
                        ListTile(
                          leading: Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: AppColours.crimson.withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Icon(Icons.emergency, color: AppColours.crimson, size: 20),
                          ),
                          title: Text(c.name, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500)),
                          trailing: Text(
                            c.phone ?? '',
                            style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: AppColours.primaryPurple),
                          ),
                        ),
                        if (i < emergency.length - 1)
                          const Divider(height: 0, indent: 16, endIndent: 16),
                      ],
                    );
                  }).toList(),
                ),
              ),
            ],
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}

class _CouncillorCard extends StatelessWidget {
  final Contact contact;
  const _CouncillorCard({required this.contact});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColours.pureWhite,
        borderRadius: BorderRadius.circular(16),
        border: const Border(left: BorderSide(color: AppColours.primaryPurple, width: 3)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            contact.name,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: AppColours.nearBlack),
          ),
          const SizedBox(height: 4),
          Text(
            contact.role ?? '',
            style: const TextStyle(fontSize: 13, color: AppColours.slate),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: FilledButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.phone, size: 18),
                  label: const Text('Call'),
                  style: FilledButton.styleFrom(
                    backgroundColor: AppColours.primaryPurple,
                    minimumSize: const Size(0, 40),
                    shape: const StadiumBorder(),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.email_outlined, size: 18),
                  label: const Text('Email'),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppColours.slate,
                    side: const BorderSide(color: AppColours.fog),
                    minimumSize: const Size(0, 40),
                    shape: const StadiumBorder(),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
