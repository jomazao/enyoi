import 'package:session_3/features/sales/domain/entities/sale.dart';

abstract class SalesRepository {
  Stream<List<Sale>> getSalesStream();
  Future<List<Sale>> getSales({double? lastTotal});
}
