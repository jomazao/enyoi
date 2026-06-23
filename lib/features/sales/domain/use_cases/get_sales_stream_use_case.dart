import 'package:session_3/features/sales/data/repositories/sales_repository_impl.dart';
import 'package:session_3/features/sales/domain/entities/sale.dart';
import 'package:session_3/features/sales/domain/repositories/sales_repository.dart';

class GetSalesStreamUseCase {
  final SalesRepository _repository;

  GetSalesStreamUseCase({SalesRepository? repository})
    : _repository = repository ?? SalesRepositoryImpl();

  Stream<List<Sale>> call() {
    return _repository.getSalesStream();
  }
}
