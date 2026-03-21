import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../theme/colours.dart';
import '../../widgets/spuerhund_button.dart';
import '../../widgets/glass_card.dart';
import '../../widgets/staggered_column.dart';

class SignupProvinceScreen extends StatefulWidget {
  const SignupProvinceScreen({super.key});

  @override
  State<SignupProvinceScreen> createState() => _SignupProvinceScreenState();
}

class _SignupProvinceScreenState extends State<SignupProvinceScreen> {
  String? _selectedProvince;

  final List<String> _provinces = [
    'Gauteng',
    'Western Cape',
    'KwaZulu-Natal',
    'Eastern Cape',
    'Free State',
    'Mpumalanga',
    'Limpopo',
    'North West',
    'Northern Cape',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: SpuerhundColours.background,
      appBar: AppBar(
        leading: const BackButton(),
        title: const Text('Create Account'),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: SpuerhundSpacing.lg,
                vertical: SpuerhundSpacing.md,
              ),
              child: StaggeredColumn(
                children: [
                  Text(
                    'Where is your property?',
                    style: GoogleFonts.epilogue(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      letterSpacing: -1,
                      color: SpuerhundColours.textPrimary,
                    ),
                  ),
                  const SizedBox(height: SpuerhundSpacing.sm),
                  Text(
                    'Select the province where your municipal account is registered.',
                    style: GoogleFonts.manrope(
                      fontSize: 16,
                      color: SpuerhundColours.textSecondary,
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.all(SpuerhundSpacing.lg),
                itemCount: _provinces.length,
                separatorBuilder: (context, index) =>
                    const SizedBox(height: 10),
                itemBuilder: (context, index) {
                  final province = _provinces[index];
                  final isSelected = _selectedProvince == province;
                  return FadeSlideIn(
                    delay: Duration(milliseconds: index * 40),
                    child: GlassCard(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 16),
                      borderRadius: SpuerhundRadius.md,
                      onTap: () {
                        setState(() => _selectedProvince = province);
                      },
                      child: Row(
                        children: [
                          AnimatedContainer(
                            duration: SpuerhundDurations.fast,
                            curve: SpuerhundCurves.spring,
                            width: 24,
                            height: 24,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: isSelected
                                    ? SpuerhundColours.primary
                                    : SpuerhundColours.divider,
                                width: 2,
                              ),
                              color: isSelected
                                  ? SpuerhundColours.primary
                                  : Colors.transparent,
                            ),
                            child: isSelected
                                ? const Icon(Icons.check_rounded,
                                    size: 16, color: Colors.white)
                                : null,
                          ),
                          const SizedBox(width: SpuerhundSpacing.md),
                          Text(
                            province,
                            style: GoogleFonts.manrope(
                              fontSize: 16,
                              fontWeight: isSelected
                                  ? FontWeight.w600
                                  : FontWeight.w500,
                              color: isSelected
                                  ? SpuerhundColours.primary
                                  : SpuerhundColours.textPrimary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
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
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SpuerhundButton(
                    text: 'Continue',
                    onPressed: () {
                      if (_selectedProvince != null) {
                        context.push('/signup-details');
                      }
                    },
                    isPrimary: _selectedProvince != null,
                  ),
                  const SizedBox(height: SpuerhundSpacing.md),
                  TextButton(
                    onPressed: () => context.push('/login'),
                    child: RichText(
                      text: TextSpan(
                        text: 'Already have an account? ',
                        style: GoogleFonts.manrope(
                          color: SpuerhundColours.textSecondary,
                          fontSize: 14,
                        ),
                        children: [
                          TextSpan(
                            text: 'Log in',
                            style: GoogleFonts.manrope(
                              color: SpuerhundColours.primary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
