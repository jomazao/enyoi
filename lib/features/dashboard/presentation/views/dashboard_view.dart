import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:session_3/core/navigation/router.dart';
import 'package:session_3/features/login_old/domain/use_cases/log_out_use_case.dart';

class BaseView extends StatelessWidget {
  final String name;
  final Widget child;

  const BaseView({super.key, required this.name, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: child);
  }
}

class DashboardView extends StatelessWidget {
  static final name = 'DashboardView';

  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    final buttonsText = ['Crédito', 'Ventas', 'Perfil', 'Cerrar sesión'];

    final buttons = buttonsText
        .map(
          (text) => InkWell(
            onTap: () {
              switch (text) {
                case 'Crédito':
                  Navigator.pushNamed(context, '/credit');
                  break;
                case 'Perfil':
                  context.goNamed(Routes.profile);
                  break;
                case 'Ventas':
                  context.goNamed(Routes.sales);
                  break;
                case 'Cerrar sesión':
                  LogOutUseCase().call();
                  context.goNamed(Routes.login);
                  // Implementar lógica de cierre de sesión
                  break;
              }
            },
            child: SizedBox(child: Text(text)),
          ),
        )
        .toList();

    return Scaffold(
      body: Center(
        child: Column(mainAxisSize: MainAxisSize.min, children: buttons),
      ),
    );
  }
}
