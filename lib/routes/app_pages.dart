import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:profixer_admin/screens/add_category/add_category_screen.dart';
import 'package:profixer_admin/screens/add_service/add_service_screen.dart';
import 'package:profixer_admin/screens/auth/mobile/mobile_login_screen.dart';
import 'package:profixer_admin/screens/auth/verification/verification_screen.dart';

import 'package:profixer_admin/screens/category_menu/category_Menu_screen.dart';

import 'package:profixer_admin/screens/main/main_screen.dart';
import 'package:profixer_admin/screens/new_ticket/new_ticket_screen.dart';
import 'package:profixer_admin/screens/onboarding/language/language_screen.dart';

import 'package:profixer_admin/screens/service_menu/service_menu_screen.dart';
import 'package:profixer_admin/screens/ticket/ticket_screen.dart';
import 'package:profixer_admin/screens/ticket_history/ticket_history_screen.dart';



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
      name: Routes.serviceMenu,
      page: () =>  ServiceMenuScreen(),
    ),
    GetPage(
      name: Routes.categoryMenu,
      page: () =>  CategoryMenuScreen(),
    ),
    GetPage(
      name: Routes.addCategory,
      page: () =>  AddCategoryScreen(),
    ),
    GetPage(
      name: Routes.newTicket,
      page: () =>  NewTicketScreen(),
    ),
    GetPage(
      name: Routes.ticket,
      page: () =>  TicketScreen(),
    ),
    GetPage(
      name: Routes.ticketHistory,
      page: () =>  TicketHistoryScreen(),
    ),
  ];
}
