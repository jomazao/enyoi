import 'dart:async';

import 'package:riverpod/legacy.dart';
import 'package:session_3/features/sales/domain/entities/sale.dart';
import 'package:session_3/features/sales/domain/use_cases/get_sales_use_case.dart';
import 'package:session_3/features/sales/presentation/state/sales_dashboard_state.dart';

final salesDashboardNoStreamProvider =
    StateNotifierProvider<SalesDashboardNoStreamNotifier, SalesDashboardState>(
      (ref) => SalesDashboardNoStreamNotifier(),
    );

class SalesDashboardNoStreamNotifier
    extends StateNotifier<SalesDashboardState> {
  SalesDashboardNoStreamNotifier({GetSalesUseCase? getSalesUseCase})
    : _getSalesUseCase = getSalesUseCase ?? GetSalesUseCase(),
      super(SalesDashboardState.initial()) {
    loadSales();
  }

  final GetSalesUseCase _getSalesUseCase;

  Future<void> loadSales({double? lastTotal}) async {
    final List<Sale> previousSales = state.when(
      initial: () => [],
      loading: (sales) => [],
      loaded: (sales) => sales,
      error: (message) => [],
    );
    state = SalesDashboardState.loading(sales: previousSales);

    try {
      final sales = await _getSalesUseCase.call(lastTotal: lastTotal);
      state = SalesDashboardState.loaded(sales: [...previousSales, ...sales]);
    } catch (e) {
      state = SalesDashboardState.error(message: 'Error al cargar productos');
    }
  }

  void refresh() {
    loadSales();
  }

  void loadMore({required double lastTotal}) {
    loadSales(lastTotal: lastTotal);
  }

  @override
  void dispose() {
    super.dispose();
  }
}
