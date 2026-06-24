import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:qc_hospital/Screens/Login/login.dart';
import 'package:qc_hospital/Screens/Login/login_as.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
void main() async {
  // 1. Ensure Flutter bindings are initialized before calling System parameters
  WidgetsFlutterBinding.ensureInitialized();

  // 2. Set the global system UI overlay style
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent, // Transparent status bar
      statusBarIconBrightness: Brightness.dark, // Dark icons
    ),
  );
  const AndroidInitializationSettings androidSettings =
  AndroidInitializationSettings('@mipmap/ic_launcher');

  final InitializationSettings initSettings =
  InitializationSettings(android: androidSettings);

  await flutterLocalNotificationsPlugin.initialize(initSettings);

  // ✅ Create high importance channel
  const AndroidNotificationChannel channel = AndroidNotificationChannel(
    'otp_channel_id',
    'OTP Notifications',
    description: 'Used for OTP notifications',
    importance: Importance.max,
  );

  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
      AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);
  ;


  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'QC Hospital',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        pageTransitionsTheme: PageTransitionsTheme(
          builders: {
            TargetPlatform.android: FadePageTransitionsBuilder(),
            TargetPlatform.iOS: FadePageTransitionsBuilder(),
            TargetPlatform.windows: FadePageTransitionsBuilder(),
            TargetPlatform.linux: FadePageTransitionsBuilder(),
            TargetPlatform.macOS: FadePageTransitionsBuilder(),
          },
        ),
        useMaterial3: false, // 🚨 CRITICAL (removes icon auto recolor system)

        primaryColor: const Color(0xFF1A1A1A),

        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,

        iconTheme: const IconThemeData(
          color: Colors.black, // default icon color globally
        ),

        colorScheme: const ColorScheme.light(primary: Color(0xFF1A1A1A)),

        // 3. CRITICAL: Stop AppBars from overriding your transparent status bar
        appBarTheme: const AppBarTheme(
          color: Colors
              .transparent, // Make app bar transparent if you want content to flow behind it
          elevation: 0,
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarIconBrightness: Brightness.dark,
          ),
        ),
      ),
      // home: LoginAs(),
      home : LoginScreen(loginby: '',)
    );
  }
}

class FadePageTransitionsBuilder extends PageTransitionsBuilder {
  const FadePageTransitionsBuilder();

  @override
  Widget buildTransitions<T>(
    PageRoute<T> route,
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    return FadeTransition(opacity: animation, child: child);
  }
}
