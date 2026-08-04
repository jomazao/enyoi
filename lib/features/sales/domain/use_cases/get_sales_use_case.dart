import 'package:session_3/features/sales/data/repositories/sales_repository_impl.dart';
import 'package:session_3/features/sales/domain/entities/sale.dart';
import 'package:session_3/features/sales/domain/repositories/sales_repository.dart';

class GetSalesUseCase {
  final SalesRepository _salesRepository;

  GetSalesUseCase({SalesRepository? salesRepository})
    : _salesRepository = salesRepository ?? SalesRepositoryImpl();

  Future<List<Sale>> call({double? lastTotal}) async {
    return await _salesRepository.getSales(lastTotal: lastTotal);
  }
}
