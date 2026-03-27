import '../../models/bill.dart';

const _holder = 'MAKOKOTLELA, L.';
const _address = '703, Eifel Towers, 254X Jorissen Street, Sunnyside, 0002';
const _accNo = '5006378452';
const _sectional = 'SS Eiffel Towers';
const _unit = 'S0023';

BillDetails _details({
  required List<BillLineItem> lineItems,
  required double balanceBroughtForward,
  required double totalCurrentLevy,
  required double totalAmountPayable,
}) =>
    BillDetails(
      accountHolder: _holder,
      address: _address,
      accountNumber: _accNo,
      sectionalTitle: _sectional,
      unitNumber: _unit,
      lineItems: lineItems,
      balanceBroughtForward: balanceBroughtForward,
      subTotalA: balanceBroughtForward,
      totalCurrentLevy: totalCurrentLevy,
      totalAmountPayable: totalAmountPayable,
      aging90Days: 0,
      aging90PlusDays: balanceBroughtForward,
    );

// ─── March 2026 (Current / Unpaid) ───

final _marWater = Bill(
  id: 'bill-mar-water',
  accountId: 'acc-001',
  period: 'Mar 2026',
  totalAmount: 456.78,
  status: BillStatus.unpaid,
  serviceType: ServiceType.water,
  issuedDate: DateTime(2026, 3, 1),
  dueDate: DateTime(2026, 4, 15),
  details: _details(
    balanceBroughtForward: 0,
    totalCurrentLevy: 456.78,
    totalAmountPayable: 456.78,
    lineItems: const [
      BillLineItem(date: '01/03/26', description: 'Basic Charge', amountExclVat: 125.00, vat: 18.75, amountInclVat: 143.75),
      BillLineItem(date: '01/03/26', description: 'Usage (14 kL)', amountExclVat: 232.90, vat: 34.94, amountInclVat: 267.84),
      BillLineItem(date: '01/03/26', description: 'Sanitation Levy', amountExclVat: 39.30, vat: 5.89, amountInclVat: 45.19),
    ],
  ),
);

final _marElec = Bill(
  id: 'bill-mar-elec',
  accountId: 'acc-001',
  period: 'Mar 2026',
  totalAmount: 892.45,
  status: BillStatus.unpaid,
  serviceType: ServiceType.electricity,
  issuedDate: DateTime(2026, 3, 1),
  dueDate: DateTime(2026, 4, 15),
  details: _details(
    balanceBroughtForward: 0,
    totalCurrentLevy: 892.45,
    totalAmountPayable: 892.45,
    lineItems: const [
      BillLineItem(date: '01/03/26', description: 'Service Charge', amountExclVat: 98.50, vat: 14.78, amountInclVat: 113.28),
      BillLineItem(date: '01/03/26', description: 'Energy (412 kWh)', amountExclVat: 578.40, vat: 86.76, amountInclVat: 665.16),
      BillLineItem(date: '01/03/26', description: 'Network Demand', amountExclVat: 99.14, vat: 14.87, amountInclVat: 114.01),
    ],
  ),
);

final _marRates = Bill(
  id: 'bill-mar-rates',
  accountId: 'acc-001',
  period: 'Mar 2026',
  totalAmount: 1247.00,
  status: BillStatus.unpaid,
  serviceType: ServiceType.ratesAndTaxes,
  issuedDate: DateTime(2026, 3, 1),
  dueDate: DateTime(2026, 4, 15),
  details: _details(
    balanceBroughtForward: 0,
    totalCurrentLevy: 1247.00,
    totalAmountPayable: 1247.00,
    lineItems: const [
      BillLineItem(date: '01/03/26', description: 'Property Rates', amountExclVat: 694.78, vat: 104.22, amountInclVat: 799.00),
      BillLineItem(date: '01/03/26', description: 'Refuse Removal', amountExclVat: 389.57, vat: 58.43, amountInclVat: 448.00),
    ],
  ),
);

final _marWaste = Bill(
  id: 'bill-mar-waste',
  accountId: 'acc-001',
  period: 'Mar 2026',
  totalAmount: 251.40,
  status: BillStatus.unpaid,
  serviceType: ServiceType.waste,
  issuedDate: DateTime(2026, 3, 1),
  dueDate: DateTime(2026, 4, 15),
  details: _details(
    balanceBroughtForward: 0,
    totalCurrentLevy: 251.40,
    totalAmountPayable: 251.40,
    lineItems: const [
      BillLineItem(date: '01/03/26', description: 'Waste Collection', amountExclVat: 186.96, vat: 28.04, amountInclVat: 215.00),
      BillLineItem(date: '01/03/26', description: 'Recycling Levy', amountExclVat: 31.65, vat: 4.75, amountInclVat: 36.40),
    ],
  ),
);

// ─── February 2026 (Unpaid) ───

final _febWater = Bill(
  id: 'bill-feb-water',
  accountId: 'acc-001',
  period: 'Feb 2026',
  totalAmount: 423.12,
  status: BillStatus.unpaid,
  serviceType: ServiceType.water,
  issuedDate: DateTime(2026, 2, 1),
  dueDate: DateTime(2026, 3, 15),
  details: _details(
    balanceBroughtForward: -212.77,
    totalCurrentLevy: 635.89,
    totalAmountPayable: 423.12,
    lineItems: const [
      BillLineItem(date: '15/07/16', description: 'Balance Brought Forward', amountExclVat: -212.77, vat: 0, amountInclVat: -212.77),
      BillLineItem(date: '01/02/26', description: 'Basic Charge', amountExclVat: 125.00, vat: 18.75, amountInclVat: 143.75),
      BillLineItem(date: '01/02/26', description: 'Usage (12 kL)', amountExclVat: 198.40, vat: 29.76, amountInclVat: 228.16),
      BillLineItem(date: '01/02/26', description: 'Sanitation Levy', amountExclVat: 39.30, vat: 5.89, amountInclVat: 45.19),
    ],
  ),
);

final _febElec = Bill(
  id: 'bill-feb-elec',
  accountId: 'acc-001',
  period: 'Feb 2026',
  totalAmount: 834.90,
  status: BillStatus.unpaid,
  serviceType: ServiceType.electricity,
  issuedDate: DateTime(2026, 2, 1),
  dueDate: DateTime(2026, 3, 15),
  details: _details(
    balanceBroughtForward: 0,
    totalCurrentLevy: 834.90,
    totalAmountPayable: 834.90,
    lineItems: const [
      BillLineItem(date: '01/02/26', description: 'Service Charge', amountExclVat: 98.50, vat: 14.78, amountInclVat: 113.28),
      BillLineItem(date: '01/02/26', description: 'Energy (378 kWh)', amountExclVat: 530.10, vat: 79.52, amountInclVat: 609.62),
      BillLineItem(date: '01/02/26', description: 'Network Demand', amountExclVat: 97.39, vat: 14.61, amountInclVat: 112.00),
    ],
  ),
);

final _febRates = Bill(
  id: 'bill-feb-rates',
  accountId: 'acc-001',
  period: 'Feb 2026',
  totalAmount: 1247.00,
  status: BillStatus.paid,
  serviceType: ServiceType.ratesAndTaxes,
  issuedDate: DateTime(2026, 2, 1),
  dueDate: DateTime(2026, 3, 15),
  details: _details(
    balanceBroughtForward: 0,
    totalCurrentLevy: 1247.00,
    totalAmountPayable: 1247.00,
    lineItems: const [
      BillLineItem(date: '01/02/26', description: 'Property Rates', amountExclVat: 694.78, vat: 104.22, amountInclVat: 799.00),
      BillLineItem(date: '01/02/26', description: 'Refuse Removal', amountExclVat: 389.57, vat: 58.43, amountInclVat: 448.00),
    ],
  ),
);

final _febWaste = Bill(
  id: 'bill-feb-waste',
  accountId: 'acc-001',
  period: 'Feb 2026',
  totalAmount: 251.40,
  status: BillStatus.paid,
  serviceType: ServiceType.waste,
  issuedDate: DateTime(2026, 2, 1),
  dueDate: DateTime(2026, 3, 15),
  details: _details(
    balanceBroughtForward: 0,
    totalCurrentLevy: 251.40,
    totalAmountPayable: 251.40,
    lineItems: const [
      BillLineItem(date: '01/02/26', description: 'Waste Collection', amountExclVat: 186.96, vat: 28.04, amountInclVat: 215.00),
      BillLineItem(date: '01/02/26', description: 'Recycling Levy', amountExclVat: 31.65, vat: 4.75, amountInclVat: 36.40),
    ],
  ),
);

// ─── January 2026 (Paid) ───

final _janWater = Bill(
  id: 'bill-jan-water',
  accountId: 'acc-001',
  period: 'Jan 2026',
  totalAmount: 389.55,
  status: BillStatus.paid,
  serviceType: ServiceType.water,
  issuedDate: DateTime(2026, 1, 1),
  dueDate: DateTime(2026, 2, 15),
  details: _details(
    balanceBroughtForward: 0,
    totalCurrentLevy: 389.55,
    totalAmountPayable: 389.55,
    lineItems: const [
      BillLineItem(date: '01/01/26', description: 'Basic Charge', amountExclVat: 125.00, vat: 18.75, amountInclVat: 143.75),
      BillLineItem(date: '01/01/26', description: 'Usage (10 kL)', amountExclVat: 175.48, vat: 26.32, amountInclVat: 201.80),
      BillLineItem(date: '01/01/26', description: 'Sanitation Levy', amountExclVat: 38.26, vat: 5.74, amountInclVat: 44.00),
    ],
  ),
);

final _janElec = Bill(
  id: 'bill-jan-elec',
  accountId: 'acc-001',
  period: 'Jan 2026',
  totalAmount: 1102.30,
  status: BillStatus.paid,
  serviceType: ServiceType.electricity,
  issuedDate: DateTime(2026, 1, 1),
  dueDate: DateTime(2026, 2, 15),
  details: _details(
    balanceBroughtForward: 0,
    totalCurrentLevy: 1102.30,
    totalAmountPayable: 1102.30,
    lineItems: const [
      BillLineItem(date: '01/01/26', description: 'Service Charge', amountExclVat: 98.50, vat: 14.78, amountInclVat: 113.28),
      BillLineItem(date: '01/01/26', description: 'Energy (520 kWh)', amountExclVat: 742.80, vat: 111.42, amountInclVat: 854.22),
      BillLineItem(date: '01/01/26', description: 'Network Demand', amountExclVat: 117.22, vat: 17.58, amountInclVat: 134.80),
    ],
  ),
);

final _janRates = Bill(
  id: 'bill-jan-rates',
  accountId: 'acc-001',
  period: 'Jan 2026',
  totalAmount: 1247.00,
  status: BillStatus.paid,
  serviceType: ServiceType.ratesAndTaxes,
  issuedDate: DateTime(2026, 1, 1),
  dueDate: DateTime(2026, 2, 15),
  details: _details(
    balanceBroughtForward: 0,
    totalCurrentLevy: 1247.00,
    totalAmountPayable: 1247.00,
    lineItems: const [
      BillLineItem(date: '01/01/26', description: 'Property Rates', amountExclVat: 694.78, vat: 104.22, amountInclVat: 799.00),
      BillLineItem(date: '01/01/26', description: 'Refuse Removal', amountExclVat: 389.57, vat: 58.43, amountInclVat: 448.00),
    ],
  ),
);

final _janWaste = Bill(
  id: 'bill-jan-waste',
  accountId: 'acc-001',
  period: 'Jan 2026',
  totalAmount: 251.40,
  status: BillStatus.paid,
  serviceType: ServiceType.waste,
  issuedDate: DateTime(2026, 1, 1),
  dueDate: DateTime(2026, 2, 15),
  details: _details(
    balanceBroughtForward: 0,
    totalCurrentLevy: 251.40,
    totalAmountPayable: 251.40,
    lineItems: const [
      BillLineItem(date: '01/01/26', description: 'Waste Collection', amountExclVat: 186.96, vat: 28.04, amountInclVat: 215.00),
      BillLineItem(date: '01/01/26', description: 'Recycling Levy', amountExclVat: 31.65, vat: 4.75, amountInclVat: 36.40),
    ],
  ),
);

// ─── December 2025 (Paid, summer = higher water) ───

final _decWater = Bill(
  id: 'bill-dec-water',
  accountId: 'acc-001',
  period: 'Dec 2025',
  totalAmount: 512.90,
  status: BillStatus.paid,
  serviceType: ServiceType.water,
  issuedDate: DateTime(2025, 12, 1),
  dueDate: DateTime(2026, 1, 15),
  details: _details(
    balanceBroughtForward: 0,
    totalCurrentLevy: 512.90,
    totalAmountPayable: 512.90,
    lineItems: const [
      BillLineItem(date: '01/12/25', description: 'Basic Charge', amountExclVat: 125.00, vat: 18.75, amountInclVat: 143.75),
      BillLineItem(date: '01/12/25', description: 'Usage (18 kL)', amountExclVat: 282.74, vat: 42.41, amountInclVat: 325.15),
      BillLineItem(date: '01/12/25', description: 'Sanitation Levy', amountExclVat: 38.26, vat: 5.74, amountInclVat: 44.00),
    ],
  ),
);

final _decElec = Bill(
  id: 'bill-dec-elec',
  accountId: 'acc-001',
  period: 'Dec 2025',
  totalAmount: 1345.80,
  status: BillStatus.paid,
  serviceType: ServiceType.electricity,
  issuedDate: DateTime(2025, 12, 1),
  dueDate: DateTime(2026, 1, 15),
  details: _details(
    balanceBroughtForward: 0,
    totalCurrentLevy: 1345.80,
    totalAmountPayable: 1345.80,
    lineItems: const [
      BillLineItem(date: '01/12/25', description: 'Service Charge', amountExclVat: 98.50, vat: 14.78, amountInclVat: 113.28),
      BillLineItem(date: '01/12/25', description: 'Energy (648 kWh)', amountExclVat: 928.44, vat: 139.27, amountInclVat: 1067.71),
      BillLineItem(date: '01/12/25', description: 'Network Demand', amountExclVat: 143.31, vat: 21.50, amountInclVat: 164.81),
    ],
  ),
);

final _decRates = Bill(
  id: 'bill-dec-rates',
  accountId: 'acc-001',
  period: 'Dec 2025',
  totalAmount: 1247.00,
  status: BillStatus.paid,
  serviceType: ServiceType.ratesAndTaxes,
  issuedDate: DateTime(2025, 12, 1),
  dueDate: DateTime(2026, 1, 15),
  details: _details(
    balanceBroughtForward: 0,
    totalCurrentLevy: 1247.00,
    totalAmountPayable: 1247.00,
    lineItems: const [
      BillLineItem(date: '01/12/25', description: 'Property Rates', amountExclVat: 694.78, vat: 104.22, amountInclVat: 799.00),
      BillLineItem(date: '01/12/25', description: 'Refuse Removal', amountExclVat: 389.57, vat: 58.43, amountInclVat: 448.00),
    ],
  ),
);

final _decWaste = Bill(
  id: 'bill-dec-waste',
  accountId: 'acc-001',
  period: 'Dec 2025',
  totalAmount: 251.40,
  status: BillStatus.paid,
  serviceType: ServiceType.waste,
  issuedDate: DateTime(2025, 12, 1),
  dueDate: DateTime(2026, 1, 15),
  details: _details(
    balanceBroughtForward: 0,
    totalCurrentLevy: 251.40,
    totalAmountPayable: 251.40,
    lineItems: const [
      BillLineItem(date: '01/12/25', description: 'Waste Collection', amountExclVat: 186.96, vat: 28.04, amountInclVat: 215.00),
      BillLineItem(date: '01/12/25', description: 'Recycling Levy', amountExclVat: 31.65, vat: 4.75, amountInclVat: 36.40),
    ],
  ),
);

// ─── November 2025 (Paid) ───

final _novWater = Bill(
  id: 'bill-nov-water',
  accountId: 'acc-001',
  period: 'Nov 2025',
  totalAmount: 378.20,
  status: BillStatus.paid,
  serviceType: ServiceType.water,
  issuedDate: DateTime(2025, 11, 1),
  dueDate: DateTime(2025, 12, 15),
  details: _details(
    balanceBroughtForward: 0,
    totalCurrentLevy: 378.20,
    totalAmountPayable: 378.20,
    lineItems: const [
      BillLineItem(date: '01/11/25', description: 'Basic Charge', amountExclVat: 125.00, vat: 18.75, amountInclVat: 143.75),
      BillLineItem(date: '01/11/25', description: 'Usage (9 kL)', amountExclVat: 165.61, vat: 24.84, amountInclVat: 190.45),
      BillLineItem(date: '01/11/25', description: 'Sanitation Levy', amountExclVat: 38.26, vat: 5.74, amountInclVat: 44.00),
    ],
  ),
);

final _novElec = Bill(
  id: 'bill-nov-elec',
  accountId: 'acc-001',
  period: 'Nov 2025',
  totalAmount: 987.60,
  status: BillStatus.paid,
  serviceType: ServiceType.electricity,
  issuedDate: DateTime(2025, 11, 1),
  dueDate: DateTime(2025, 12, 15),
  details: _details(
    balanceBroughtForward: 0,
    totalCurrentLevy: 987.60,
    totalAmountPayable: 987.60,
    lineItems: const [
      BillLineItem(date: '01/11/25', description: 'Service Charge', amountExclVat: 98.50, vat: 14.78, amountInclVat: 113.28),
      BillLineItem(date: '01/11/25', description: 'Energy (456 kWh)', amountExclVat: 652.80, vat: 97.92, amountInclVat: 750.72),
      BillLineItem(date: '01/11/25', description: 'Network Demand', amountExclVat: 107.48, vat: 16.12, amountInclVat: 123.60),
    ],
  ),
);

final _novRates = Bill(
  id: 'bill-nov-rates',
  accountId: 'acc-001',
  period: 'Nov 2025',
  totalAmount: 1247.00,
  status: BillStatus.paid,
  serviceType: ServiceType.ratesAndTaxes,
  issuedDate: DateTime(2025, 11, 1),
  dueDate: DateTime(2025, 12, 15),
  details: _details(
    balanceBroughtForward: 0,
    totalCurrentLevy: 1247.00,
    totalAmountPayable: 1247.00,
    lineItems: const [
      BillLineItem(date: '01/11/25', description: 'Property Rates', amountExclVat: 694.78, vat: 104.22, amountInclVat: 799.00),
      BillLineItem(date: '01/11/25', description: 'Refuse Removal', amountExclVat: 389.57, vat: 58.43, amountInclVat: 448.00),
    ],
  ),
);

final _novWaste = Bill(
  id: 'bill-nov-waste',
  accountId: 'acc-001',
  period: 'Nov 2025',
  totalAmount: 251.40,
  status: BillStatus.paid,
  serviceType: ServiceType.waste,
  issuedDate: DateTime(2025, 11, 1),
  dueDate: DateTime(2025, 12, 15),
  details: _details(
    balanceBroughtForward: 0,
    totalCurrentLevy: 251.40,
    totalAmountPayable: 251.40,
    lineItems: const [
      BillLineItem(date: '01/11/25', description: 'Waste Collection', amountExclVat: 186.96, vat: 28.04, amountInclVat: 215.00),
      BillLineItem(date: '01/11/25', description: 'Recycling Levy', amountExclVat: 31.65, vat: 4.75, amountInclVat: 36.40),
    ],
  ),
);

// ─── October 2025 (Paid) ───

final _octWater = Bill(
  id: 'bill-oct-water',
  accountId: 'acc-001',
  period: 'Oct 2025',
  totalAmount: 345.00,
  status: BillStatus.paid,
  serviceType: ServiceType.water,
  issuedDate: DateTime(2025, 10, 1),
  dueDate: DateTime(2025, 11, 15),
  details: _details(
    balanceBroughtForward: 0,
    totalCurrentLevy: 345.00,
    totalAmountPayable: 345.00,
    lineItems: const [
      BillLineItem(date: '01/10/25', description: 'Basic Charge', amountExclVat: 125.00, vat: 18.75, amountInclVat: 143.75),
      BillLineItem(date: '01/10/25', description: 'Usage (8 kL)', amountExclVat: 142.83, vat: 21.42, amountInclVat: 164.25),
      BillLineItem(date: '01/10/25', description: 'Sanitation Levy', amountExclVat: 32.17, vat: 4.83, amountInclVat: 37.00),
    ],
  ),
);

final _octElec = Bill(
  id: 'bill-oct-elec',
  accountId: 'acc-001',
  period: 'Oct 2025',
  totalAmount: 876.40,
  status: BillStatus.paid,
  serviceType: ServiceType.electricity,
  issuedDate: DateTime(2025, 10, 1),
  dueDate: DateTime(2025, 11, 15),
  details: _details(
    balanceBroughtForward: 0,
    totalCurrentLevy: 876.40,
    totalAmountPayable: 876.40,
    lineItems: const [
      BillLineItem(date: '01/10/25', description: 'Service Charge', amountExclVat: 98.50, vat: 14.78, amountInclVat: 113.28),
      BillLineItem(date: '01/10/25', description: 'Energy (398 kWh)', amountExclVat: 569.74, vat: 85.46, amountInclVat: 655.20),
      BillLineItem(date: '01/10/25', description: 'Network Demand', amountExclVat: 93.84, vat: 14.08, amountInclVat: 107.92),
    ],
  ),
);

final _octRates = Bill(
  id: 'bill-oct-rates',
  accountId: 'acc-001',
  period: 'Oct 2025',
  totalAmount: 1247.00,
  status: BillStatus.paid,
  serviceType: ServiceType.ratesAndTaxes,
  issuedDate: DateTime(2025, 10, 1),
  dueDate: DateTime(2025, 11, 15),
  details: _details(
    balanceBroughtForward: 0,
    totalCurrentLevy: 1247.00,
    totalAmountPayable: 1247.00,
    lineItems: const [
      BillLineItem(date: '01/10/25', description: 'Property Rates', amountExclVat: 694.78, vat: 104.22, amountInclVat: 799.00),
      BillLineItem(date: '01/10/25', description: 'Refuse Removal', amountExclVat: 389.57, vat: 58.43, amountInclVat: 448.00),
    ],
  ),
);

final _octWaste = Bill(
  id: 'bill-oct-waste',
  accountId: 'acc-001',
  period: 'Oct 2025',
  totalAmount: 251.40,
  status: BillStatus.paid,
  serviceType: ServiceType.waste,
  issuedDate: DateTime(2025, 10, 1),
  dueDate: DateTime(2025, 11, 15),
  details: _details(
    balanceBroughtForward: 0,
    totalCurrentLevy: 251.40,
    totalAmountPayable: 251.40,
    lineItems: const [
      BillLineItem(date: '01/10/25', description: 'Waste Collection', amountExclVat: 186.96, vat: 28.04, amountInclVat: 215.00),
      BillLineItem(date: '01/10/25', description: 'Recycling Levy', amountExclVat: 31.65, vat: 4.75, amountInclVat: 36.40),
    ],
  ),
);

// ─── Master list ───

final mockBills = [
  _marWater, _marElec, _marRates, _marWaste,
  _febWater, _febElec, _febRates, _febWaste,
  _janWater, _janElec, _janRates, _janWaste,
  _decWater, _decElec, _decRates, _decWaste,
  _novWater, _novElec, _novRates, _novWaste,
  _octWater, _octElec, _octRates, _octWaste,
];
