import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../theme/colours.dart';
import '../../widgets/common/spuerhund_button.dart';
import '../../widgets/common/spuerhund_input.dart';

class LinkAccountsScreen extends StatefulWidget {
  const LinkAccountsScreen({super.key});

  @override
  State<LinkAccountsScreen> createState() => _LinkAccountsScreenState();
}

class _LinkAccountsScreenState extends State<LinkAccountsScreen> {
  int _selectedPropertyType = 0;
  final _accountController = TextEditingController();
  final Set<String> _selectedServices = {'Water', 'Electricity'};

  static const _propertyTypes = [
    ('Individual Property', Icons.home_rounded),
    ('Sectional Title', Icons.apartment_rounded),
    ('Estate', Icons.villa_rounded),
  ];

  static const _services = [
    'Water',
    'Electricity',
    'Rates and Taxes',
    'Waste',
    'Sanitation',
    'Refuse Removal',
  ];

  @override
  void dispose() {
    _accountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColours.pureWhite,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_rounded),
          onPressed: () => context.go('/signup/details'),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Link Your Accounts',
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.w700,
                  color: AppColours.nearBlack,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Connect your municipal accounts to start tracking.',
                style: TextStyle(fontSize: 15, color: AppColours.slate),
              ),
              const SizedBox(height: 24),
              Row(
                children: List.generate(_propertyTypes.length, (i) {
                  final isSelected = i == _selectedPropertyType;
                  return Expanded(
                    child: GestureDetector(
                      onTap: () =>
                          setState(() => _selectedPropertyType = i),
                      child: Container(
                        margin: EdgeInsets.only(
                          right: i < _propertyTypes.length - 1 ? 8 : 0,
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? AppColours.whisperPurple
                              : AppColours.cloudGrey,
                          borderRadius: BorderRadius.circular(16),
                          border: isSelected
                              ? Border.all(
                                  color: AppColours.primaryPurple, width: 1.5)
                              : null,
                        ),
                        child: Column(
                          children: [
                            Icon(
                              _propertyTypes[i].$2,
                              size: 28,
                              color: isSelected
                                  ? AppColours.primaryPurple
                                  : AppColours.slate,
                            ),
                            const SizedBox(height: 8),
                            Text(
                              _propertyTypes[i].$1,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: isSelected
                                    ? AppColours.primaryPurple
                                    : AppColours.slate,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }),
              ),
              const SizedBox(height: 24),
              SpuerhundInput(
                label: 'Account Number',
                hint: 'Enter your account number',
                controller: _accountController,
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 4),
              const Text(
                'Find this on your municipal statement.',
                style: TextStyle(fontSize: 12, color: AppColours.slate),
              ),
              const SizedBox(height: 24),
              const Text(
                'Services to track',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: AppColours.slate,
                ),
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: _services.map((s) {
                  final isSelected = _selectedServices.contains(s);
                  return GestureDetector(
                    onTap: () => setState(() {
                      if (isSelected) {
                        _selectedServices.remove(s);
                      } else {
                        _selectedServices.add(s);
                      }
                    }),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? AppColours.primaryPurple
                            : AppColours.cloudGrey,
                        borderRadius: BorderRadius.circular(100),
                      ),
                      child: Text(
                        s,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: isSelected
                              ? AppColours.pureWhite
                              : AppColours.nearBlack,
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 16),
              GestureDetector(
                onTap: () {},
                child: const Text(
                  '+ Add another account',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: AppColours.primaryPurple,
                  ),
                ),
              ),
              const SizedBox(height: 32),
              SpuerhundButton(
                label: 'Link Accounts',
                onPressed: () => context.go('/home'),
              ),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }
}
