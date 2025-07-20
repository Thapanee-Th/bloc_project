import 'package:bloc_project/view/login_screen.dart';
import 'package:bloc_project/view/profile_screen.dart';
import 'package:flutter/material.dart';
import 'app_routes.dart';

class AppPages {
  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.login:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case AppRoutes.profile:
        return MaterialPageRoute(builder: (_) => const ProfileScreen());
      default:
        return null;
    }
  }
}
