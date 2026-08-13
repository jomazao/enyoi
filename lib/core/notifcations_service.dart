import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:session_3/core/environment/env.dart';
import 'package:session_3/core/log_data_source.dart';
import 'package:session_3/core/navigation/router.dart';

@pragma('vm:entry-point')
Future<void> _firebaseBackgroundHandler(RemoteMessage message) async {
  try {
    Env.environment = Environment.development;
  } catch (e) {
    print('already set: $e');
  }

  await Env.initialize();
  await Firebase.initializeApp(options: Env.firebaseOptions);

  // Trabajo corto y sin UI: cachear, contar, loguear
  final data = message.data;
  // await _guardarEnCacheLocal(data);
  print('Background message received: ${message.notification?.title}');
  print('Background message data: $data');

  LogDataSource logDataSource = LogDataSource();
  await logDataSource.logEvent('background_message', {
    ...data,
    'title': message.notification?.title ?? '',
  });
}

class NotificationsService {
  NotificationsService({
    FirebaseMessaging? firebaseMessaging,
    FlutterLocalNotificationsPlugin? localNotifications,
  }) : _localNotifications =
           localNotifications ?? FlutterLocalNotificationsPlugin(),
       _firebaseMessaging = firebaseMessaging ?? FirebaseMessaging.instance;

  final FirebaseMessaging _firebaseMessaging;
  final FlutterLocalNotificationsPlugin _localNotifications;

  RemoteMessage? _initialMessage;

  Future<void> init() async {
    await _requestPermissions();
    await _initRemoteNotifications();
    await _initLocalNotifications();
    _initBackgroundHandler();
    _initMessageOpenedApp();
  }

  Future<void> _requestPermissions() async {
    // Initialize local notifications here
    final actualSettings = await _firebaseMessaging.getNotificationSettings();
    print(
      'Actual notification settings: ${actualSettings.authorizationStatus}',
    );

    final settings = await _firebaseMessaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
    print('Notification settings: ${settings.authorizationStatus}');
  }

  Future<void> _initRemoteNotifications() async {
    final token = await _firebaseMessaging.getToken();
    _firebaseMessaging.onTokenRefresh.listen((newToken) {
      print('FCM Token refreshed: $newToken');
    });
    print('FCM Token: $token');

    await _initLocalNotifications();
    FirebaseMessaging.onMessage.listen(_foregroundMessageHandler);
  }

  void _foregroundMessageHandler(RemoteMessage message) {
    if (message.notification != null) {
      print('Foreground message received: ${message.notification!.title}');
      _showLocalNotification(message);
    }

    // Handle the foreground message here
  }

  Future<void> _initLocalNotifications() async {
    // Initialize local notifications here

    const canal = AndroidNotificationChannel(
      'canal_alta_prioridad',
      'Avisos importantes',
      importance: Importance.high, // sin esto no suena ni aparece flotante
    );

    await _localNotifications
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >()
        ?.createNotificationChannel(canal);

    await _localNotifications.initialize(
      settings: const InitializationSettings(
        android: AndroidInitializationSettings('@mipmap/ic_launcher'),
        iOS: DarwinInitializationSettings(),
      ),
      onDidReceiveNotificationResponse: (r) =>
          print('se presionó la notificación'), // el tap
    );
  }

  Future<void> _showLocalNotification(RemoteMessage message) async {
    const androidDetails = AndroidNotificationDetails(
      'default_channel',
      'General',
      channelDescription: 'General notifications',
      importance: Importance.max,
      priority: Priority.high,
    );

    const details = NotificationDetails(android: androidDetails);

    await _localNotifications.show(
      id: 0,
      title: message.notification?.title ?? 'Notificación',
      body: message.notification?.body ?? 'Esta es una notificación local',
      notificationDetails: details,
    );
  }

  void _initBackgroundHandler() {
    FirebaseMessaging.onBackgroundMessage(_firebaseBackgroundHandler);
  }

  void _initMessageOpenedApp() {
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      print('Notification opened: ${message.notification?.title}');

      // Handle the notification tap here

      final title = message.notification?.title ?? '';
      final data = message.data;

      switch (title) {
        case 'Profile':
          router.goNamed(Routes.profile);
          break;
        case 'Sales':
          router.goNamed(Routes.sales, extra: data);
          break;
        default:
          router.goNamed(Routes.dashboard);
      }
    });
  }

  Future<RemoteMessage?> getInitialMessage() async {
    _initialMessage = await _firebaseMessaging.getInitialMessage();
    return _initialMessage;
  }
}
