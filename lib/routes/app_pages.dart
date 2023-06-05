import 'package:get/get.dart';
import 'package:profixer_admin/screens/area/add_area/add_area_screen.dart';
import 'package:profixer_admin/screens/area/area_list/area_list_screen.dart';
import 'package:profixer_admin/screens/auth/mobile/mobile_login_screen.dart';
import 'package:profixer_admin/screens/auth/verification/verification_screen.dart';
import 'package:profixer_admin/screens/bank_details/bank_details_screen.dart';
import 'package:profixer_admin/screens/city/add_city/add_city_screen.dart';
import 'package:profixer_admin/screens/city/city_list/city_list_screen.dart';
import 'package:profixer_admin/screens/complaint_nature/add_complaint_nature/add_complaint_nature_screen.dart';

import 'package:profixer_admin/screens/complaint_nature/complaint_nature_list/complaint_nature_list_screen.dart';
import 'package:profixer_admin/screens/customer/customer/add_customer/add_customer_screen.dart';
import 'package:profixer_admin/screens/customer/customer/customer_list/customer_list_screen.dart';
import 'package:profixer_admin/screens/customer/customer_address/add_address/add_address_screen.dart';


import 'package:profixer_admin/screens/holiday/add_holiday/add_holiday_screen.dart';
import 'package:profixer_admin/screens/main/main_screen.dart';
import 'package:profixer_admin/screens/main/profile/change_details/change_details_screen.dart';
import 'package:profixer_admin/screens/main/profile/change_password/change_password_screen.dart';
import 'package:profixer_admin/screens/onboarding/language/language_screen.dart';
import 'package:profixer_admin/screens/onboarding/login_selection/login_selection_screen.dart';
import 'package:profixer_admin/screens/profixer/add_profixer/add_profixer_screen.dart';
import 'package:profixer_admin/screens/profixer/profixer_list/profixer_list_screen.dart';
import 'package:profixer_admin/screens/service_provider/service_provider/add_service_provider/add_service_provider.dart';
import 'package:profixer_admin/screens/service_provider/service_provider/service_provider_list/service_provider_list_screen.dart';
import 'package:profixer_admin/screens/service_provider/service_provider_admin/add_service_provider_admin/add_admin_service_provider.dart';


import 'package:profixer_admin/screens/technician/add_techinican/add_technician_screen.dart';
import 'package:profixer_admin/screens/technician/technician_list/technician_list_screen.dart';


import 'package:profixer_admin/screens/tickets/booked_ticket/booked_ticket_screen.dart';
import 'package:profixer_admin/screens/tickets/new_ticket/new_ticket_screen.dart';
import 'package:profixer_admin/screens/tickets/ticket_details/ticket_details_screen.dart';

import '../screens/auth/login/login_screen.dart';
import '../screens/holiday/holiday_list/holiday_list_screen.dart';
import '../screens/service/add_service/add_service_screen.dart';
import '../screens/service/service_list/service_list_screen.dart';

import '../screens/tickets/check_customer/check_customer_screen.dart';
import 'app_routes.dart';

class AppPages {
  static final routes = [
    GetPage(
      name: Routes.language,
      page: () => const LanguageScreen(),
    ),
    GetPage(
      name: Routes.loginSelection,
      page: () => const LoginSelectionScreen(),
    ),
    GetPage(
      name: Routes.login,
      page: () => LoginScreen(),
    ),
    GetPage(
      name: Routes.mobileLogin,
      page: () => MobileLoginScreen(),
    ),
    GetPage(
      name: Routes.verification,
      page: () => VerificationScreen(),
    ),
    GetPage(
      name: Routes.main,
      page: () => MainScreen(),
    ),
    GetPage(
      name: Routes.addComplaintNature,
      page: () => AddComplaintNatureScreen(),
    ),
    GetPage(
      name: Routes.complaintNatureList,
      page: () => ComplaintNatureListScreen(),
    ),
    GetPage(
      name: Routes.serviceList,
      page: () => ServiceListScreen(),
    ),
    GetPage(
      name: Routes.addService,
      page: () => AddServiceScreen(),
    ),
    GetPage(
      name: Routes.checkCustomer,
      page: () => CheckCustomerScreen(),
    ),
    GetPage(
      name: Routes.newTicket,
      page: () => NewTicketScreen(),
    ),
    GetPage(
      name: Routes.bookedTicket,
      page: () => BookedTicketScreen(),
    ),
    GetPage(
      name: Routes.ticketDetails,
      page: () => const TicketDetailsScreen(),
    ),
    GetPage(
      name: Routes.technicianList,
      page: () => TechnicianListScreen(),
    ),
    GetPage(
      name: Routes.addTechnician,
      page: () => AddTechnicianScreen(),
    ),
    GetPage(
      name: Routes.profixerList,
      page: () => ProfixerListScreen(),
    ),
    GetPage(
      name: Routes.addProfixer,
      page: () => AddProfixerScreen(),
    ),
    GetPage(
      name: Routes.serviceProviderList,
      page: () => ServiceProviderListScreen(),
    ),
    GetPage(
      name: Routes.addServiceProvider,
      page: () => AddServiceProviderScreen(),
    ),
    GetPage(
      name: Routes.addAdminServiceProvider,
      page: () => AddAdminServiceProvider(),
    ),
    GetPage(
      name: Routes.bankDetails,
      page: () => BankDetailsScreen(),
    ),
    GetPage(
      name: Routes.changePassword,
      page: () => ChangePasswordScreen(),
    ),
    GetPage(
      name: Routes.changeDetails,
      page: () => ChangeDetailsScreen(),
    ),
    GetPage(
      name: Routes.cityList,
      page: () => CityListScreen(),
    ),
    GetPage(
      name: Routes.addCity,
      page: () => AddCityScreen(),
    ),
    GetPage(
      name: Routes.addArea,
      page: () => AddAreaScreen(),
    ),
    GetPage(
      name: Routes.areaList,
      page: () => AreaListScreen(),
    ),
    GetPage(
      name: Routes.addHoliday,
      page: () => AddHolidayScreen(),
    ),
    GetPage(
      name: Routes.holidayList,
      page: () => HolidayListScreen(),
    ),
    GetPage(
      name: Routes.addCustomer,
      page: () => AddCustomerScreen(),
    ),
    GetPage(
      name: Routes.addCustomerAddress,
      page: () => AddAddressScreen(),
    ),

    GetPage(

      name: Routes.customerList,
      page: () => CustomerListScreen(),
    ),
  ];
}
