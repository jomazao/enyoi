import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:session_3/features/sales/presentation/state/sales_dashboard_notifier.dart';
import 'package:session_3/features/sales/presentation/state/sales_dashboard_state.dart';

class SalesDashboardView extends ConsumerWidget {
  const SalesDashboardView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(salesDashboardProvider);

    final Widget child = state.when(
      initial: () => SizedBox.shrink(),
      loading: (sales) => CircularProgressIndicator(),
      loaded: (sales) => ListView(
        children: sales
            .map((sale) => Center(child: Text('${sale.total}')))
            .toList(),
      ),
      error: (message) => Text(message),
    );

    return Scaffold(
      appBar: AppBar(),
      body: Center(child: child),
    );
  }
}
