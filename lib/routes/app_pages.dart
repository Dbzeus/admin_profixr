import 'package:get/get.dart';
import 'package:profixer_admin/screens/onboarding/language/language_screen.dart';
import 'app_routes.dart';

class AppPages {
  static final routes = [
    GetPage(
      name: Routes.Language,
      page: () => const LanguageScreen(),
    ),
  ];
}
