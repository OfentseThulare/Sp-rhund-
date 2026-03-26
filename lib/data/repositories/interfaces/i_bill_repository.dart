import '../../../models/bill.dart';

abstract class IBillRepository {
  List<Bill> getBills();
  Bill? getBillById(String id);
  List<Bill> getBillsByStatus(BillStatus status);
}
