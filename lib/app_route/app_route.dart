import 'package:flutter/material.dart';
import 'package:optizenqor/feature/authentication/splash/splash_screen/splash_screen.dart';
import 'package:optizenqor/feature/master/home/home_screen/home_screen.dart';

class AppRoute {
  static const String splash = '/';
  static const String home = '/home';

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splash:
        return MaterialPageRoute<void>(
          builder: (_) => const SplashScreen(),
          settings: settings,
        );
      case home:
        return MaterialPageRoute<void>(
          builder: (_) => const HomeScreen(),
          settings: settings,
        );
      default:
        return MaterialPageRoute<void>(
          builder: (_) =>
              const Scaffold(body: Center(child: Text('Page not found'))),
        );
    }
  }
}
