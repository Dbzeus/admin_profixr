import 'package:get/get.dart';
import 'package:profixer_admin/screens/home/home_screen.dart';
import 'package:profixer_admin/screens/login/login_screen.dart';
import 'package:profixer_admin/screens/onboarding/language/language_screen.dart';
import 'package:profixer_admin/screens/onboarding/onboarding/onboarding_screen.dart';
import 'app_routes.dart';

class AppPages {
  static final routes = [
    GetPage(
      name: Routes.Language,
      page: () => const LanguageScreen(),
    ),
    GetPage(
      name: Routes.Onboarding,
      page: () =>  OnboardingScreen(),

    ),
    GetPage(
      name: Routes.Login,
      page: () =>  LoginScreen(),

    ),
    GetPage(
      name: Routes.Home,
      page: () =>  HomeScreen(),

    ),
  ];
}
