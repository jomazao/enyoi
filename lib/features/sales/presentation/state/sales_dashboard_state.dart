import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:session_3/features/sales/domain/entities/sale.dart';

part 'sales_dashboard_state.freezed.dart';

@freezed
abstract class SalesDashboardState with _$SalesDashboardState {
  const factory SalesDashboardState.initial() = _Initial;

  const factory SalesDashboardState.loading({
    required List<Sale> sales,
  }) = _Loading;

  const factory SalesDashboardState.loaded({
    required List<Sale> sales,
  }) = _Loaded;

  const factory SalesDashboardState.error({required String message}) =
      _Error;
}
