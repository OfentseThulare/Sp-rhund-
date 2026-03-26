import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../theme/colours.dart';
import '../../theme/typography.dart';
import '../../widgets/common/spuerhund_button.dart';
import '../../widgets/common/spuerhund_input.dart';

class LinkAccountsScreen extends StatefulWidget {
  const LinkAccountsScreen({super.key});

  @override
  State<LinkAccountsScreen> createState() => _LinkAccountsScreenState();
}

class _LinkAccountsScreenState extends State<LinkAccountsScreen> {
  final _formKey = GlobalKey<FormState>();
  final _accountController = TextEditingController();
  String _selectedMunicipality = 'City of Tshwane';
  String _selectedPropertyType = 'Flat';
  bool _isLoading = false;

  static const _municipalities = [
    'City of Tshwane',
    'City of Johannesburg',
  ];

  static const _propertyTypes = [
    'Flat',
    'Townhouse',
    'House',
    'Commercial',
  ];

  @override
  void dispose() {
    _accountController.dispose();
    super.dispose();
  }

  Future<void> _connectAccount() async {
    setState(() => _isLoading = true);
    await Future.delayed(const Duration(seconds: 2));
    if (mounted) {
      context.go('/home');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColours.voidBlack,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded, color: AppColours.textPrimary),
          onPressed: () => context.go('/signup'),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Icon(
                Icons.apartment_rounded,
                size: 48,
                color: Colors.white,
              ),
              const SizedBox(height: 24),
              Semantics(
                header: true,
                child: Text(
                  'Link Your Municipal Account',
                  textAlign: TextAlign.center,
                  style: AppTypography.headlineLarge.copyWith(
                    fontSize: 26,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Connect your account to see your bills and alerts.',
                textAlign: TextAlign.center,
                style: AppTypography.bodyLarge.copyWith(
                  color: AppColours.textSecondary,
                ),
              ),
              const SizedBox(height: 32),
              Container(
                height: 52,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: AppColours.surface,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppColours.borderLight),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: _selectedMunicipality,
                    isExpanded: true,
                    dropdownColor: AppColours.surface,
                    style: AppTypography.bodyLarge.copyWith(
                      color: Colors.white,
                      fontSize: 15,
                    ),
                    icon: const Icon(
                      Icons.keyboard_arrow_down_rounded,
                      color: AppColours.textSecondary,
                    ),
                    items: _municipalities.map((m) {
                      return DropdownMenuItem<String>(
                        value: m,
                        child: Text(m),
                      );
                    }).toList(),
                    onChanged: (value) {
                      if (value != null) {
                        setState(() => _selectedMunicipality = value);
                      }
                    },
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Form(
                key: _formKey,
                child: SpuerhundInput(
                label: 'Account Number',
                hint: 'Enter your account number',
                controller: _accountController,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter your account number';
                  }
                  return null;
                },
                suffixIcon: IconButton(
                  icon: const Icon(
                    Icons.help_outline_rounded,
                    color: AppColours.textSecondary,
                  ),
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                          'Find your account number on your municipal statement',
                        ),
                      ),
                    );
                  },
                ),
              ),
              ),
              const SizedBox(height: 16),
              Align(
                alignment: Alignment.centerLeft,
                child: Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: _propertyTypes.map((type) {
                    final isSelected = _selectedPropertyType == type;
                    return ChoiceChip(
                      label: Text(type),
                      selected: isSelected,
                      onSelected: (_) {
                        setState(() => _selectedPropertyType = type);
                      },
                      selectedColor: AppColours.primaryPurple,
                      backgroundColor: AppColours.surface,
                      side: BorderSide(
                        color: isSelected
                            ? AppColours.primaryPurple
                            : AppColours.borderLight,
                      ),
                      labelStyle: TextStyle(
                        color: isSelected
                            ? Colors.white
                            : AppColours.textSecondary,
                        fontWeight: FontWeight.w500,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      showCheckmark: false,
                    );
                  }).toList(),
                ),
              ),
              const SizedBox(height: 32),
              SpuerhundButton(
                label: 'Connect Account',
                isLoading: _isLoading,
                onPressed: _isLoading ? null : () {
                  if (_formKey.currentState!.validate()) {
                    _connectAccount();
                  }
                },
              ),
              const SizedBox(height: 16),
              Semantics(
                button: true,
                label: 'Skip account linking',
                child: GestureDetector(
                  onTap: () => context.go('/home'),
                  child: SizedBox(
                    height: 44,
                    child: Center(
                      child: Text(
                        'Skip for now',
                        style: AppTypography.bodyMedium.copyWith(
                          color: AppColours.textSecondary,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }
}
