import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../theme/colours.dart';
import '../../view_models/disputes_view_model.dart';
import '../../widgets/disputes/dispute_tile.dart';

class DisputesListScreen extends StatelessWidget {
  const DisputesListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<DisputesViewModel>();

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
                    'Disputes',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                      color: AppColours.nearBlack,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    decoration: BoxDecoration(
                      color: AppColours.whisperPurple,
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: Text(
                      '${vm.openCount} open',
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: AppColours.primaryPurple,
                      ),
                    ),
                  ),
                  const Spacer(),
                  GestureDetector(
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('New dispute feature coming soon'),
                          duration: Duration(seconds: 2),
                        ),
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                      decoration: BoxDecoration(
                        color: AppColours.primaryPurple,
                        borderRadius: BorderRadius.circular(100),
                      ),
                      child: const Text(
                        '+ New',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: AppColours.pureWhite,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              ...vm.disputes.map((d) => Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: DisputeTile(
                      dispute: d,
                      onTap: () => context.push('/disputes/${d.id}'),
                    ),
                  )),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
