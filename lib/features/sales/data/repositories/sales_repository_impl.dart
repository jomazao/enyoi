import 'package:session_3/features/sales/data/data_sources/sales_firebase_data_source.dart';
import 'package:session_3/features/sales/data/models/sale_model.dart';
import 'package:session_3/features/sales/domain/entities/sale.dart';
import 'package:session_3/features/sales/domain/repositories/sales_repository.dart';

class SalesRepositoryImpl extends SalesRepository {
  final SalesFirebaseDataSource _dataSource;

  SalesRepositoryImpl({SalesFirebaseDataSource? datasource})
    : _dataSource = datasource ?? SalesFirebaseDataSource();

  @override
  Stream<List<Sale>> getSalesStream() {
    return _dataSource.getSalesModelsStream().map(
      (list) => list.toEntityList(),
    );
  }

  @override
  Future<List<Sale>> getSales({double? lastTotal}) {
    return _dataSource
        .getSalesModels(lastTotal: lastTotal)
        .then((list) => list.toEntityList());
  }
}
