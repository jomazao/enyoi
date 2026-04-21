import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:session_3/features/accounts/presentation/states/credit_request_provider.dart';
import 'package:session_3/features/accounts/presentation/views/credit_request_view.dart';
import 'package:session_3/features/dashboard/presentation/state/dashboard_provider.dart';
import 'package:session_3/features/dashboard/presentation/views/dashboard_view.dart';
import 'package:session_3/features/login/presentation/state/login_cubit.dart';
import 'package:session_3/features/login/presentation/state/login_provider.dart';
import 'package:session_3/features/login/presentation/views/login_cubit_view.dart';
import 'package:session_3/features/login/presentation/views/login_view.dart';
import 'package:session_3/features/profile/views/dashboard_view.dart';

final router = GoRouter(
  routes: [
    GoRoute(
      name: Routes.login,
      path: '/old',
      builder: (context, state) => ChangeNotifierProvider<LoginProvider>(
        create: (_) => LoginProvider()..checkIfLogged(),
        child: const LoginView(),
      ),
    ),
    GoRoute(
      name: Routes.loginCubit,
      path: '/',
      builder: (context, state) => BlocProvider<LoginCubit>(
        create: (_) => LoginCubit()..checkIfLogged(),
        child: const LoginCubitView(),
      ),
    ),

    ShellRoute(
      builder: (context, state, child) => Scaffold(
        appBar: AppBar(
          title: Text('Enyoi Bank'),
          backgroundColor: Colors.green,
        ),
        body: Column(
          children: [
            Expanded(flex: 70, child: child),
            Expanded(flex: 10, child: Container(color: Colors.orange)),
            Expanded(flex: 10, child: Container(color: Colors.red)),
          ],
        ),
      ),
      routes: [
        GoRoute(
          name: Routes.dashboard,
          path: '/dashboard',
          builder: (context, state) =>
              ChangeNotifierProvider<DashboardProvider>(
                create: (_) => DashboardProvider(),
                child: DashboardView(),
              ),
          routes: [
            GoRoute(
              name: Routes.creditRequest,
              path: 'solicitud-credito',
              builder: (context, state) =>
                  ChangeNotifierProvider<CreditRequestProvider>(
                    create: (_) => CreditRequestProvider(),
                    child: CreditRequestView(),
                  ),
            ),
          ],
        ),
        GoRoute(
          name: Routes.profile,
          path: '/profile',
          builder: (context, state) => ProfileView(),
        ),
      ],
    ),
  ],
);

abstract class Routes {
  static const String login = 'login';
  static const String loginCubit = 'login_cubit';
  static const String dashboard = 'dashboard';
  static const String creditRequest = 'solicitud-credito';
  static const String profile = 'profile';
}
