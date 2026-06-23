import 'dart:async';

import 'package:riverpod/legacy.dart';
import 'package:session_3/features/sales/domain/use_cases/get_sales_stream_use_case.dart';
import 'package:session_3/features/sales/presentation/state/sales_dashboard_state.dart';

final salesDashboardProvider =
    StateNotifierProvider<SalesDashboardNotifier, SalesDashboardState>(
      (ref) => SalesDashboardNotifier(),
    );

class SalesDashboardNotifier extends StateNotifier<SalesDashboardState> {
  SalesDashboardNotifier({GetSalesStreamUseCase? getSalesStreamUseCase})
    : _getSalesStreamUseCase = getSalesStreamUseCase ?? GetSalesStreamUseCase(),
      super(SalesDashboardState.initial()) {
    initSubscription();
  }

  final GetSalesStreamUseCase _getSalesStreamUseCase;

  StreamSubscription? _subscription;

  Future<void> initSubscription() async {
    state = SalesDashboardState.loading(sales: []);

    try {
      _subscription = _getSalesStreamUseCase.call().listen((sales) {
        state = SalesDashboardState.loaded(sales: sales);
      });
    } catch (e) {
      state = SalesDashboardState.error(message: 'Error al cargar productos');
    }
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }
}
