import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../theme/colours.dart';
import '../../widgets/spuerhund_button.dart';
import '../../widgets/app_text_field.dart';
import '../../widgets/staggered_column.dart';

class LinkAccountsScreen extends StatelessWidget {
  const LinkAccountsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: SpuerhundColours.background,
      appBar: AppBar(
        leading: const BackButton(),
        title: const Text('Link Accounts'),
        actions: [
          TextButton(
            onPressed: () => context.go('/dashboard'),
            child: Text(
              'Skip',
              style: GoogleFonts.manrope(
                color: SpuerhundColours.primary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(SpuerhundSpacing.lg),
                child: StaggeredColumn(
                  staggerDelay: const Duration(milliseconds: 50),
                  children: [
                    // Info banner
                    Container(
                      padding: const EdgeInsets.all(SpuerhundSpacing.md),
                      decoration: BoxDecoration(
                        color: SpuerhundColours.primaryTint,
                        borderRadius:
                            BorderRadius.circular(SpuerhundRadius.md),
                        border: Border.all(
                          color:
                              SpuerhundColours.primary.withValues(alpha: 0.15),
                        ),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 36,
                            height: 36,
                            decoration: BoxDecoration(
                              color: SpuerhundColours.primary
                                  .withValues(alpha: 0.1),
                              borderRadius:
                                  BorderRadius.circular(SpuerhundRadius.xs),
                            ),
                            child: const Icon(Icons.info_outline_rounded,
                                color: SpuerhundColours.primary, size: 18),
                          ),
                          const SizedBox(width: SpuerhundSpacing.sm + 4),
                          Expanded(
                            child: Text(
                              'Have your latest municipal bill ready to verify your account.',
                              style: GoogleFonts.manrope(
                                color: SpuerhundColours.primaryDark,
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                height: 1.4,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: SpuerhundSpacing.xl),
                    const AppTextField(
                      label: 'Account Number',
                      hint: 'e.g., 5006378452',
                      keyboardType: TextInputType.number,
                      prefixIcon: Icons.numbers_rounded,
                    ),
                    const SizedBox(height: SpuerhundSpacing.lg),
                    const AppTextField(
                      label: 'Stand / Erf Number',
                      hint: 'Required by Tshwane',
                      prefixIcon: Icons.location_on_outlined,
                    ),
                    const SizedBox(height: SpuerhundSpacing.lg),
                    const AppTextField(
                      label: 'Property Name (Optional)',
                      hint: 'e.g., Home, Office',
                      prefixIcon: Icons.home_outlined,
                    ),
                  ],
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(SpuerhundSpacing.lg),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border(
                    top: BorderSide(
                        color: SpuerhundColours.divider
                            .withValues(alpha: 0.5))),
              ),
              child: SpuerhundButton(
                text: 'Link Account & Proceed',
                onPressed: () {
                  context.go('/dashboard');
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
