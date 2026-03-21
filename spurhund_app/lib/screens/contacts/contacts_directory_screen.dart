import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../theme/colours.dart';
import '../../widgets/glass_card.dart';
import '../../widgets/shimmer_loader.dart';
import '../../widgets/staggered_column.dart';
import '../../view_models/contact_view_model.dart';
import '../../models/contact.dart' show Contact;

class ContactsDirectoryScreen extends StatefulWidget {
  const ContactsDirectoryScreen({super.key});

  @override
  State<ContactsDirectoryScreen> createState() =>
      _ContactsDirectoryScreenState();
}

class _ContactsDirectoryScreenState extends State<ContactsDirectoryScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ContactViewModel>().loadContacts();
    });
  }

  @override
  Widget build(BuildContext context) {
    final contactVm = context.watch<ContactViewModel>();

    return Scaffold(
      backgroundColor: SpuerhundColours.background,
      appBar: AppBar(
        leading: const BackButton(),
        title: const Text('City Contacts'),
      ),
      body: SafeArea(
        child: contactVm.isLoading
            ? ListView(
                padding: const EdgeInsets.all(SpuerhundSpacing.lg),
                children: List.generate(
                  5,
                  (i) => Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: ListItemSkeleton(),
                  ),
                ),
              )
            : ListView(
                padding: const EdgeInsets.all(SpuerhundSpacing.lg),
                children: [
                  if (contactVm.councillor != null) ...[
                    Text(
                      'Your Local Councillor',
                      style: GoogleFonts.epilogue(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        letterSpacing: -0.5,
                        color: SpuerhundColours.textPrimary,
                      ),
                    ),
                    const SizedBox(height: SpuerhundSpacing.md),
                    FadeSlideIn(
                      child: GlassCard(
                        isDoubleBezel: true,
                        padding: const EdgeInsets.all(20),
                        child: Row(
                          children: [
                            Container(
                              width: 56,
                              height: 56,
                              decoration: BoxDecoration(
                                color: SpuerhundColours.primaryTint,
                                borderRadius:
                                    BorderRadius.circular(SpuerhundRadius.md),
                              ),
                              child: const Center(
                                child: Icon(Icons.person_rounded,
                                    color: SpuerhundColours.primary, size: 28),
                              ),
                            ),
                            const SizedBox(width: SpuerhundSpacing.md),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    contactVm.councillor!.name,
                                    style: GoogleFonts.epilogue(
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 2),
                                  Text(
                                    contactVm.councillor!.ward,
                                    style: GoogleFonts.manrope(
                                      color: SpuerhundColours.primary,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 13,
                                    ),
                                  ),
                                  const SizedBox(height: SpuerhundSpacing.sm),
                                  Row(
                                    children: [
                                      const Icon(Icons.phone_rounded,
                                          size: 14,
                                          color:
                                              SpuerhundColours.textTertiary),
                                      const SizedBox(width: 6),
                                      Text(
                                        contactVm.councillor!.phoneNumber,
                                        style: GoogleFonts.manrope(
                                          color:
                                              SpuerhundColours.textSecondary,
                                          fontSize: 13,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: SpuerhundSpacing.xl),
                  ],
                  Text(
                    'Emergency & Services',
                    style: GoogleFonts.epilogue(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      letterSpacing: -0.5,
                      color: SpuerhundColours.textPrimary,
                    ),
                  ),
                  const SizedBox(height: SpuerhundSpacing.md),
                  ...contactVm.contacts.asMap().entries.map(
                        (entry) => FadeSlideIn(
                          delay: Duration(milliseconds: entry.key * 60),
                          child: _buildContactItem(entry.value),
                        ),
                      ),
                ],
              ),
      ),
    );
  }

  Widget _buildContactItem(Contact contact) {
    IconData getIcon(String key) {
      return switch (key) {
        'water_drop' => Icons.water_drop_rounded,
        'bolt' => Icons.bolt_rounded,
        'receipt' => Icons.receipt_long_rounded,
        'delete' => Icons.delete_rounded,
        _ => Icons.phone_rounded,
      };
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(SpuerhundRadius.lg),
        border: Border.all(color: SpuerhundColours.border),
        boxShadow: SpuerhundShadows.subtle,
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: SpuerhundColours.surfaceMuted,
              borderRadius: BorderRadius.circular(SpuerhundRadius.sm),
            ),
            child: Icon(getIcon(contact.iconKey),
                color: SpuerhundColours.primary, size: 22),
          ),
          const SizedBox(width: SpuerhundSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  contact.departmentName,
                  style: GoogleFonts.manrope(
                    fontWeight: FontWeight.w700,
                    fontSize: 15,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  contact.category,
                  style: GoogleFonts.manrope(
                    color: SpuerhundColours.textSecondary,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: SpuerhundColours.primaryTint,
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.phone_in_talk_rounded,
                color: SpuerhundColours.primary, size: 18),
          ),
        ],
      ),
    );
  }
}
