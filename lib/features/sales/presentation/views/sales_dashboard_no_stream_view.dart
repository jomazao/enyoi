import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:session_3/features/sales/presentation/state/sales_dashboard_no_stream_notifier.dart';
import 'package:session_3/features/sales/presentation/state/sales_dashboard_notifier.dart';
import 'package:session_3/features/sales/presentation/state/sales_dashboard_state.dart';

class SalesDashboardViewNoStream extends ConsumerWidget {
  const SalesDashboardViewNoStream({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(salesDashboardNoStreamProvider);

    final Widget child = state.when(
      initial: () => SizedBox.shrink(),
      loading: (sales) => CircularProgressIndicator(),
      loaded: (sales) => ListView(
        children: [
          ...sales.map((sale) => Center(child: Text('${sale.total}'))).toList(),
          TextButton(
            onPressed: () {
              ref
                  .read(salesDashboardNoStreamProvider.notifier)
                  .loadMore(lastTotal: sales.last.total);
            },
            child: Text('Cargar más'),
          ),
        ],
      ),
      error: (message) => Text(message),
    );

    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: RefreshIndicator(
          onRefresh: () async {
            print('refreshing');
            ref.read(salesDashboardNoStreamProvider.notifier).refresh();
          },

          child: child,
        ),
      ),
    );
  }
}
