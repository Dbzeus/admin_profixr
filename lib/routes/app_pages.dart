
import 'package:get/get.dart';
import 'package:profixer_admin/screens/area/add_area/add_area_screen.dart';
import 'package:profixer_admin/screens/area/area_list/area_list_screen.dart';




import 'package:profixer_admin/screens/auth/mobile/mobile_login_screen.dart';
import 'package:profixer_admin/screens/auth/verification/verification_screen.dart';
import 'package:profixer_admin/screens/bank_details/bank_details_screen.dart';
import 'package:profixer_admin/screens/category/add_category/add_category_screen.dart';
import 'package:profixer_admin/screens/category/category_menu/category_Menu_screen.dart';
import 'package:profixer_admin/screens/city/add_city/add_city_screen.dart';
import 'package:profixer_admin/screens/city/city_list/city_list_screen.dart';



import 'package:profixer_admin/screens/main/main_screen.dart';
import 'package:profixer_admin/screens/main/profile/change_details/change_details_screen.dart';

import 'package:profixer_admin/screens/main/profile/change_password/change_password_screen.dart';

import 'package:profixer_admin/screens/onboarding/language/language_screen.dart';
import 'package:profixer_admin/screens/onboarding/login_selection/login_selection_screen.dart';
import 'package:profixer_admin/screens/services/add_service/add_service_screen.dart';
import 'package:profixer_admin/screens/services/service_menu/service_menu_screen.dart';
import 'package:profixer_admin/screens/techinican_details/techinician_details_screen.dart';
import 'package:profixer_admin/screens/tickets/booked_ticket/booked_ticket_screen.dart';
import 'package:profixer_admin/screens/tickets/new_ticket/new_ticket_screen.dart';
import 'package:profixer_admin/screens/tickets/ticket_details/ticket_details_screen.dart';






import '../screens/auth/login/login_screen.dart';
import 'app_routes.dart';

class AppPages {
  static final routes = [
    GetPage(
      name: Routes.language,
      page: () => const LanguageScreen(),
    ),GetPage(
      name: Routes.loginSelection,
      page: () => const LoginSelectionScreen(),
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
      name: Routes.bookedTicket,
      page: () =>  BookedTicketScreen(),
    ),
    GetPage(
      name: Routes.ticketDetails,
      page: () =>  const TicketDetailsScreen(),
    ),
    GetPage(
      name: Routes.technicianDetails,
      page: () =>  TechnicianDetailsScreen(),
    ),
    GetPage(
      name: Routes.bankDetails,
      page: () =>  BankDetailsScreen(),
    ),
    GetPage(
      name: Routes.changePassword,
      page: () =>  ChangePasswordScreen(),
    ),
    GetPage(
      name: Routes.changeDetails,
      page: () =>  ChangeDetailsScreen(),
    ),
    GetPage(
      name: Routes.cityList,
      page: () =>  CityListScreen(),
    ),
    GetPage(
      name: Routes.addCity,
      page: () =>  AddCityScreen(),
    ),
    GetPage(
      name: Routes.addarea,
      page: () =>  AddAreaScreen(),
    ),
    GetPage(
      name: Routes.areaList,
      page: () =>  AreaListScreen(),
    ),
  ];
}
