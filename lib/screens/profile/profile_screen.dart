import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../theme/colours.dart';
import '../../view_models/auth_view_model.dart';
import '../../data/mock/mock_user.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool _pushNotifications = true;
  bool _billReminders = true;
  bool _dueDateAlerts = true;
  bool _serviceDisruptions = true;
  bool _biometricLogin = true;
  bool _twoFactor = false;
  bool _darkMode = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColours.cloudGrey,
      body: SafeArea(
        child: ListView(
          children: [
            const SizedBox(height: 16),
            _buildProfileHeader(),
            const SizedBox(height: 24),
            _sectionLabel('Account'),
            _settingsGroup([
              _settingsTile('Linked Accounts', trailing: '3 accounts'),
              _settingsTile('Property Type', trailing: 'Individual'),
              _settingsTile('Municipality', trailing: 'City of Tshwane'),
            ]),
            const SizedBox(height: 24),
            _sectionLabel('Notifications'),
            _settingsGroup([
              _toggleTile('Push Notifications', _pushNotifications,
                  (v) => setState(() => _pushNotifications = v)),
              _toggleTile('Bill Reminders', _billReminders,
                  (v) => setState(() => _billReminders = v)),
              _toggleTile('Due Date Alerts', _dueDateAlerts,
                  (v) => setState(() => _dueDateAlerts = v)),
              _toggleTile('Service Disruptions', _serviceDisruptions,
                  (v) => setState(() => _serviceDisruptions = v)),
            ]),
            const SizedBox(height: 24),
            _sectionLabel('Security'),
            _settingsGroup([
              _settingsTile('Change Password', showChevron: true),
              _toggleTile('Biometric Login', _biometricLogin,
                  (v) => setState(() => _biometricLogin = v)),
              _toggleTile('Two Factor Authentication', _twoFactor,
                  (v) => setState(() => _twoFactor = v)),
            ]),
            const SizedBox(height: 24),
            _sectionLabel('App'),
            _settingsGroup([
              _settingsTile('Language', trailing: 'English'),
              _toggleTile('Dark Mode', _darkMode,
                  (v) => setState(() => _darkMode = v)),
              _settingsTile('Help and Support', showChevron: true),
              _settingsTile('Terms and Conditions', showChevron: true),
              _settingsTile('Privacy Policy', showChevron: true),
            ]),
            const SizedBox(height: 24),
            Center(
              child: GestureDetector(
                onTap: () {
                  context.read<AuthViewModel>().signOut();
                  context.go('/onboarding');
                },
                child: const Text(
                  'Sign Out',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: AppColours.crimson,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            const Center(
              child: Text(
                'Spurhund v1.0.0',
                style: TextStyle(fontSize: 12, color: AppColours.ash),
              ),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileHeader() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(20),
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
        children: [
          Container(
            width: 64,
            height: 64,
            decoration: const BoxDecoration(
              color: AppColours.primaryPurple,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                mockUser.initials,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                  color: AppColours.pureWhite,
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            'Mr ${mockUser.fullName.split(' ').first}',
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: AppColours.nearBlack,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            mockUser.email,
            style: const TextStyle(fontSize: 14, color: AppColours.slate),
          ),
          const SizedBox(height: 8),
          GestureDetector(
            onTap: () {},
            child: const Text(
              'Edit Profile',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: AppColours.primaryPurple,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _sectionLabel(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: AppColours.slate,
        ),
      ),
    );
  }

  Widget _settingsGroup(List<Widget> children) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: AppColours.pureWhite,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: children.asMap().entries.map((entry) {
          final i = entry.key;
          final child = entry.value;
          return Column(
            children: [
              child,
              if (i < children.length - 1)
                const Divider(height: 0, indent: 16, endIndent: 16, color: AppColours.fog),
            ],
          );
        }).toList(),
      ),
    );
  }

  Widget _settingsTile(String title, {String? trailing, bool showChevron = false}) {
    return ListTile(
      title: Text(title, style: const TextStyle(fontSize: 15)),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (trailing != null)
            Text(trailing, style: const TextStyle(fontSize: 14, color: AppColours.slate)),
          if (showChevron)
            const Icon(Icons.chevron_right, color: AppColours.fog, size: 20),
        ],
      ),
    );
  }

  Widget _toggleTile(String title, bool value, ValueChanged<bool> onChanged) {
    return ListTile(
      title: Text(title, style: const TextStyle(fontSize: 15)),
      trailing: Switch.adaptive(
        value: value,
        onChanged: onChanged,
        activeColor: AppColours.primaryPurple,
      ),
    );
  }
}
