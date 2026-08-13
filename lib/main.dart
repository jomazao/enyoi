import 'package:bloc/bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:provider/provider.dart';
import 'package:session_3/app_colors.dart';
import 'package:session_3/core/dependencies.dart';
import 'package:session_3/core/environment/env.dart';
import 'package:session_3/core/local_storage.dart';
import 'package:session_3/core/navigation/router.dart';
import 'package:session_3/core/notifcations_service.dart';
import 'package:session_3/core/utils/my_bloc_observer.dart';
import 'package:session_3/features/login_old/presentation/state/login_provider.dart';
import 'package:session_3/l10n/app_localizations.dart';

void runProject() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Env.initialize();
  await LocalStorage().init();
  await setupDependencies();
  await Firebase.initializeApp(options: Env.firebaseOptions);
  await NotificationsService().init();
  Bloc.observer = MyBlocObserver();

  runApp(ProviderScope(child: const MainApp()));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final initialMessage = await NotificationsService().getInitialMessage();
      if (initialMessage != null) {
        // Handle the initial message when the app is opened from a terminated state
        print(
          'App opened from terminated state with message: ${initialMessage.data}',
        );
        // You can navigate to a specific screen based on the message data here
      }
      final title = initialMessage?.notification?.title ?? '';

      switch (title) {
        case 'Profile':
          router.goNamed(Routes.profile);
          break;
        case 'Sales':
          router.goNamed(Routes.sales);
          break;
        default:
        //router.goNamed(Routes.dashboard);
      }
    });

    return ChangeNotifierProvider(
      create: (_) => LoginProvider()..checkIfLogged(),
      child: MaterialApp.router(
        theme: ThemeData(
          primaryColor: AppColors.primaryColor,
          fontFamily: 'Inter',
        ),
        title: Env.appName,
        supportedLocales: [const Locale('en', 'US'), const Locale('es', 'ES')],
        localizationsDelegates: [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        routerConfig: router,
      ),
    );
  }
}
