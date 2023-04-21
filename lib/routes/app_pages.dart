import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:profixer_admin/screens/add_category/add_category_screen.dart';
import 'package:profixer_admin/screens/add_service/add_service_screen.dart';
import 'package:profixer_admin/screens/auth/mobile/mobile_login_screen.dart';
import 'package:profixer_admin/screens/auth/verification/verification_screen.dart';
import 'package:profixer_admin/screens/category/category_screen.dart';

import 'package:profixer_admin/screens/main/main_screen.dart';
import 'package:profixer_admin/screens/onboarding/language/language_screen.dart';
import 'package:profixer_admin/screens/service/service_screen.dart';


import '../screens/auth/login/login_screen.dart';
import 'app_routes.dart';

class AppPages {
  static final routes = [
    GetPage(
      name: Routes.language,
      page: () => const LanguageScreen(),
    ),
    GetPage(
      name: Routes.login,
      page: () =>  LoginScreen(),
    ),
    GetPage(
      name: Routes.mobileLogin,
      page: () =>  MobileLoginScreen(),
    ),
    GetPage(
      name: Routes.verification,
      page: () =>  VerificationScreen(),
    ),
    GetPage(
      name: Routes.main,
      page: () =>  MainScreen(),
    ),
    GetPage(
      name: Routes.addService,
      page: () =>  AddServiceScreen(),
    ),
    GetPage(
      name: Routes.service,
      page: () =>  ServiceScreen(),
    ),
    GetPage(
      name: Routes.category,
      page: () =>  CategoryScreen(),
    ),
    GetPage(
      name: Routes.addCategory,
      page: () =>  AddCategoryScreen(),
    ),
  ];
}
