import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../theme/colours.dart';
import '../../models/bill.dart';
import '../../view_models/accounts_view_model.dart';

class BillDetailScreen extends StatelessWidget {
  final String billId;
  const BillDetailScreen({super.key, required this.billId});

  @override
  Widget build(BuildContext context) {
    final bill = context.read<AccountsViewModel>().getBillById(billId);
    if (bill == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Bill Detail')),
        body: const Center(child: Text('Bill not found')),
      );
    }

    final fmt = NumberFormat.currency(locale: 'en_ZA', symbol: 'R ', decimalDigits: 2);
    final details = bill.details;

    return Scaffold(
      backgroundColor: AppColours.pureWhite,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_rounded),
          onPressed: () => context.pop(),
        ),
        title: Text(bill.period),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (details != null) ...[
              _buildHeader(details),
              const SizedBox(height: 20),
              _buildTable(details, fmt),
              const SizedBox(height: 20),
              _buildSummary(details, fmt),
              const SizedBox(height: 20),
              _buildAging(details, fmt),
              const SizedBox(height: 20),
              _buildPaymentMethods(details),
            ] else ...[
              Center(
                child: Column(
                  children: [
                    const SizedBox(height: 40),
                    Text(
                      bill.period,
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                        color: AppColours.nearBlack,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      fmt.format(bill.totalAmount),
                      style: const TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.w600,
                        color: AppColours.primaryPurple,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      bill.status.displayName,
                      style: const TextStyle(fontSize: 16, color: AppColours.slate),
                    ),
                  ],
                ),
              ),
            ],
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BillDetails d) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColours.cloudGrey,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.account_balance, color: AppColours.primaryPurple, size: 20),
              const SizedBox(width: 8),
              const Text(
                'City of Tshwane',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: AppColours.nearBlack,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          _infoRow('Account Holder', d.accountHolder),
          _infoRow('Address', d.address),
          _infoRow('Account No', d.accountNumber),
          _infoRow('Sectional Title', d.sectionalTitle),
          _infoRow('Unit', d.unitNumber),
        ],
      ),
    );
  }

  Widget _infoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              label,
              style: const TextStyle(fontSize: 13, color: AppColours.slate),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: AppColours.nearBlack,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTable(BillDetails d, NumberFormat fmt) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColours.fog),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            color: AppColours.cloudGrey,
            child: const Row(
              children: [
                Expanded(flex: 2, child: Text('Details', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: AppColours.slate))),
                Expanded(child: Text('Excl VAT', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: AppColours.slate), textAlign: TextAlign.right)),
                Expanded(child: Text('VAT', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: AppColours.slate), textAlign: TextAlign.right)),
                Expanded(child: Text('Incl VAT', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: AppColours.slate), textAlign: TextAlign.right)),
              ],
            ),
          ),
          ...d.lineItems.asMap().entries.map((entry) {
            final i = entry.key;
            final item = entry.value;
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              color: i.isEven ? AppColours.pureWhite : AppColours.cloudGrey,
              child: Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Text(item.description, style: const TextStyle(fontSize: 12, color: AppColours.nearBlack)),
                  ),
                  Expanded(child: Text(fmt.format(item.amountExclVat), style: const TextStyle(fontSize: 12), textAlign: TextAlign.right)),
                  Expanded(child: Text(fmt.format(item.vat), style: const TextStyle(fontSize: 12), textAlign: TextAlign.right)),
                  Expanded(child: Text(fmt.format(item.amountInclVat), style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500), textAlign: TextAlign.right)),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildSummary(BillDetails d, NumberFormat fmt) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColours.whisperPurple,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          _summaryRow('Balance Brought Forward (A)', fmt.format(d.subTotalA)),
          _summaryRow('Total Current Levy (B)', fmt.format(d.totalCurrentLevy)),
          const Divider(color: AppColours.softLavender, height: 16),
          _summaryRow(
            'Total Amount Payable (A+B)',
            fmt.format(d.totalAmountPayable),
            bold: true,
          ),
        ],
      ),
    );
  }

  Widget _summaryRow(String label, String value, {bool bold = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 13,
              fontWeight: bold ? FontWeight.w600 : FontWeight.w400,
              color: AppColours.nearBlack,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 14,
              fontWeight: bold ? FontWeight.w700 : FontWeight.w500,
              color: bold ? AppColours.primaryPurple : AppColours.nearBlack,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAging(BillDetails d, NumberFormat fmt) {
    return Row(
      children: [
        Expanded(
          child: _agingBox('90 Days', fmt.format(d.aging90Days)),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _agingBox('90+ Days', fmt.format(d.aging90PlusDays)),
        ),
      ],
    );
  }

  Widget _agingBox(String label, String value) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColours.cloudGrey,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Text(label, style: const TextStyle(fontSize: 12, color: AppColours.slate)),
          const SizedBox(height: 4),
          Text(value, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }

  Widget _buildPaymentMethods(BillDetails d) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Payment Methods',
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: AppColours.nearBlack),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 12,
          runSpacing: 8,
          children: d.paymentMethods.map((m) => Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: AppColours.cloudGrey,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(m, style: const TextStyle(fontSize: 13, color: AppColours.nearBlack)),
              )).toList(),
        ),
      ],
    );
  }
}
