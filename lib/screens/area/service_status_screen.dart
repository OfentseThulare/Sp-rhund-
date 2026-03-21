import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../theme/colours.dart';
import '../../view_models/status_view_model.dart';
import '../../widgets/area/status_card.dart';

class ServiceStatusScreen extends StatelessWidget {
  const ServiceStatusScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<StatusViewModel>();

    return Scaffold(
      backgroundColor: AppColours.pureWhite,
      body: SafeArea(
        child: RefreshIndicator(
          color: AppColours.primaryPurple,
          onRefresh: vm.refresh,
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            children: [
              const SizedBox(height: 16),
              Row(
                children: [
                  const Text(
                    'Service Status',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                      color: AppColours.nearBlack,
                    ),
                  ),
                  const Spacer(),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: AppColours.cloudGrey,
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.location_on, size: 14, color: AppColours.primaryPurple),
                        SizedBox(width: 4),
                        Text(
                          'Sunnyside, Tshwane',
                          style: TextStyle(fontSize: 12, color: AppColours.slate, fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              ...vm.alerts.map((alert) => Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: StatusCard(alert: alert),
                  )),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
