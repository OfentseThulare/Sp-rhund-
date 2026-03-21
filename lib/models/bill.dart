class Bill {
  final String id;
  final String accountId;
  final String period;
  final double totalAmount;
  final BillStatus status;
  final DateTime? issuedDate;
  final DateTime? dueDate;
  final BillDetails? details;
  final int serviceCount;

  const Bill({
    required this.id,
    required this.accountId,
    required this.period,
    required this.totalAmount,
    required this.status,
    this.issuedDate,
    this.dueDate,
    this.details,
    this.serviceCount = 4,
  });
}

enum BillStatus {
  paid,
  unpaid;

  String get displayName {
    switch (this) {
      case BillStatus.paid:
        return 'Paid';
      case BillStatus.unpaid:
        return 'Unpaid';
    }
  }
}

class BillDetails {
  final String accountHolder;
  final String address;
  final String accountNumber;
  final String sectionalTitle;
  final String unitNumber;
  final List<BillLineItem> lineItems;
  final double balanceBroughtForward;
  final double subTotalA;
  final double totalCurrentLevy;
  final double totalAmountPayable;
  final double aging90Days;
  final double aging90PlusDays;
  final List<String> paymentMethods;

  const BillDetails({
    required this.accountHolder,
    required this.address,
    required this.accountNumber,
    required this.sectionalTitle,
    required this.unitNumber,
    required this.lineItems,
    required this.balanceBroughtForward,
    required this.subTotalA,
    required this.totalCurrentLevy,
    required this.totalAmountPayable,
    required this.aging90Days,
    required this.aging90PlusDays,
    this.paymentMethods = const ['EasyPay', 'FNB', 'ABSA', 'Standard Bank', 'Nedbank'],
  });
}

class BillLineItem {
  final String date;
  final String description;
  final double amountExclVat;
  final double vat;
  final double amountInclVat;

  const BillLineItem({
    required this.date,
    required this.description,
    required this.amountExclVat,
    required this.vat,
    required this.amountInclVat,
  });
}
