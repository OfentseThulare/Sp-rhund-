class Bill {
  final String id;
  final String accountId;
  final String period; // e.g. "February 2026"
  final double totalAmount;
  final String status; // 'paid', 'unpaid'
  final DateTime issuedDate;
  final DateTime dueDate;
  final int serviceCount;

  const Bill({
    required this.id,
    required this.accountId,
    required this.period,
    required this.totalAmount,
    required this.status,
    required this.issuedDate,
    required this.dueDate,
    required this.serviceCount,
  });
}
