import 'package:flutter/material.dart';
import 'package:movement_reminder/app/pages.dart';
// import 'package:movement_reminder/app/pages/diary/diary_view.dart';
import 'package:movement_reminder/app/pages/home/home_view.dart';
import 'package:movement_reminder/app/pages/splash/splash_view.dart';

class RouterApp {
  RouterApp() : routeObserver = RouteObserver<PageRoute>();
  final RouteObserver<PageRoute> routeObserver;

  Route<dynamic> getRoute(RouteSettings settings) {
    switch (settings.name) {
      case Pages.home:
        return _buildRoute(settings, HomePage());
      case Pages.splash:
        return _buildRoute(settings, SplashPage());
      // case Pages.diary:
      //   return _buildRoute(settings, DiaryPage());
    }

    return _buildRoute(settings, SplashPage());
  }

  MaterialPageRoute<dynamic> _buildRoute(
    RouteSettings settings,
    Widget builder,
  ) {
    return MaterialPageRoute<dynamic>(
      settings: settings,
      builder: (BuildContext ctx) => builder,
    );
  }
}
