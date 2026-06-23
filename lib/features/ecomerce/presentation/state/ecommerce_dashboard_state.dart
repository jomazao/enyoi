import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:session_3/features/ecomerce/domain/entities/product.dart';

part 'ecommerce_dashboard_state.freezed.dart';

@freezed
abstract class EcommerceDashboardState with _$EcommerceDashboardState {
  const factory EcommerceDashboardState.initial() = _Initial;

  const factory EcommerceDashboardState.loading({
    required List<Product> products,
  }) = _Loading;

  const factory EcommerceDashboardState.loaded({
    required List<Product> products,
  }) = _Loaded;

  const factory EcommerceDashboardState.error({required String message}) =
      _Error;
}
