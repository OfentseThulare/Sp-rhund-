import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../theme/colours.dart';
import '../../view_models/auth_view_model.dart';
import '../../widgets/common/spuerhund_button.dart';

class SignUpProvinceScreen extends StatelessWidget {
  const SignUpProvinceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authVm = context.watch<AuthViewModel>();

    return Scaffold(
      backgroundColor: AppColours.pureWhite,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_rounded),
          onPressed: () => context.go('/onboarding'),
        ),
        title: const Text('Create Account'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _ProgressIndicator(step: 1),
              const SizedBox(height: 32),
              _SelectionCard(
                label: 'Select Province',
                value: authVm.selectedProvince,
                onTap: () => _showProvincePicker(context, authVm),
              ),
              const SizedBox(height: 16),
              _SelectionCard(
                label: 'Select Municipality',
                value: authVm.selectedMunicipality,
                onTap: authVm.selectedProvince != null
                    ? () => _showMunicipalityPicker(context, authVm)
                    : null,
              ),
              const Spacer(),
              SpuerhundButton(
                label: 'Continue',
                onPressed: authVm.selectedProvince != null &&
                        authVm.selectedMunicipality != null
                    ? () => context.go('/signup/details')
                    : null,
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  void _showProvincePicker(BuildContext context, AuthViewModel authVm) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => ListView(
        shrinkWrap: true,
        children: [
          const Padding(
            padding: EdgeInsets.all(16),
            child: Text(
              'Select Province',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
          ),
          ...authVm.provinces.map(
            (p) => ListTile(
              title: Text(p.name),
              trailing: authVm.selectedProvince == p.name
                  ? const Icon(Icons.check, color: AppColours.primaryPurple)
                  : null,
              onTap: () {
                authVm.selectProvince(p.name);
                Navigator.pop(context);
              },
            ),
          ),
        ],
      ),
    );
  }

  void _showMunicipalityPicker(BuildContext context, AuthViewModel authVm) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => ListView(
        shrinkWrap: true,
        children: [
          const Padding(
            padding: EdgeInsets.all(16),
            child: Text(
              'Select Municipality',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
          ),
          ...authVm.availableMunicipalities.map(
            (m) => ListTile(
              title: Text(m),
              trailing: authVm.selectedMunicipality == m
                  ? const Icon(Icons.check, color: AppColours.primaryPurple)
                  : null,
              onTap: () {
                authVm.selectMunicipality(m);
                Navigator.pop(context);
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _ProgressIndicator extends StatelessWidget {
  final int step;
  const _ProgressIndicator({required this.step});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(3, (i) {
        return Expanded(
          child: Container(
            height: 4,
            margin: EdgeInsets.only(right: i < 2 ? 8 : 0),
            decoration: BoxDecoration(
              color: i < step
                  ? AppColours.primaryPurple
                  : AppColours.fog,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
        );
      }),
    );
  }
}

class _SelectionCard extends StatelessWidget {
  final String label;
  final String? value;
  final VoidCallback? onTap;

  const _SelectionCard({
    required this.label,
    this.value,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColours.cloudGrey,
          borderRadius: BorderRadius.circular(16),
          border: value != null
              ? const Border(
                  left: BorderSide(color: AppColours.primaryPurple, width: 3),
                )
              : null,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.04),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(
                    fontSize: 13,
                    color: AppColours.slate,
                  ),
                ),
                if (value != null) ...[
                  const SizedBox(height: 4),
                  Text(
                    value!,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: AppColours.primaryPurple,
                    ),
                  ),
                ],
              ],
            ),
            Icon(
              Icons.chevron_right,
              color: onTap != null ? AppColours.slate : AppColours.fog,
            ),
          ],
        ),
      ),
    );
  }
}
