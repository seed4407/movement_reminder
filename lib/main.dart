import 'package:flutter/material.dart';
import 'package:movement_reminder/app/pages/splash/splash_view.dart';
import 'package:provider/provider.dart';
import 'package:movement_reminder/app/router_app.dart';
import 'package:movement_reminder/theme_notifier.dart';
import 'package:movement_reminder/theme_default.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:movement_reminder/notification_service.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await NotificationService().init();

  await Firebase.initializeApp();
  runApp(
    ChangeNotifierProvider(create: (_) => ThemeNotifier(), child: const Main()),
  );
}

class Main extends StatelessWidget {
  const Main({super.key});

  @override
  Widget build(BuildContext context) {
    final RouterApp routerApp = RouterApp();

    return ChangeNotifierProvider(
      create: (_) => ThemeNotifier(),
      child: Consumer<ThemeNotifier>(
        builder: (context, themeNotifier, child) {
          return MaterialApp(
            navigatorKey: navigatorKey,
            title: 'Personal Diary',
            navigatorObservers: [routerApp.routeObserver],
            onGenerateRoute: routerApp.getRoute,
            debugShowCheckedModeBanner: false,
            theme: buildLightTheme(themeNotifier),
            darkTheme: buildDarkTheme(themeNotifier),
            themeMode: themeNotifier.isDarkMode
                ? ThemeMode.dark
                : ThemeMode.light,
            home: const SplashPage(),
          );
        },
      ),
    );
  }
}
