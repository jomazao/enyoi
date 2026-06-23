import 'package:riverpod/legacy.dart';
import 'package:session_3/features/ecomerce/domain/use_cases/get_products_use_case.dart';
import 'package:session_3/features/ecomerce/presentation/state/ecommerce_dashboard_state.dart';

final loginRiverpodProvider =
    StateNotifierProvider<EcommerceDashboardNotifier, EcommerceDashboardState>(
      (ref) => EcommerceDashboardNotifier(),
    );

class EcommerceDashboardNotifier
    extends StateNotifier<EcommerceDashboardState> {
  EcommerceDashboardNotifier({GetProductsUseCase? getProductsUseCase})
    : _getProductsUseCase = getProductsUseCase ?? GetProductsUseCase(),
      super(EcommerceDashboardState.initial());

  final GetProductsUseCase _getProductsUseCase;

  Future<void> getProducts() async {
    state = EcommerceDashboardState.loading(products: []);
    try {
      final products = await _getProductsUseCase.call();

      state = EcommerceDashboardState.loaded(products: products);
    } catch  (e) {
      state = EcommerceDashboardState.error(
        message: 'Error al cargar productos',
      );
    }
  }
}
