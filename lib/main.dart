import 'package:alice/alice.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:profixer_admin/helpers/constant_widgets.dart';
import 'package:profixer_admin/helpers/custom_colors.dart';
import 'package:profixer_admin/routes/app_pages.dart';
import 'package:profixer_admin/routes/app_routes.dart';

import 'helpers/utils.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //check session
  await GetStorage.init();

  String route =  Routes.language;
  var box = GetStorage();

  if (box.read(Session.isLogin) ?? false) {
      route = Routes.main;
  }
  runApp( MyApp(route));
}

class MyApp extends StatelessWidget {
  static Alice alice = Alice(
  showNotification: true,
  showInspectorOnShake: true,
  );

  MyApp(this.initialRoute, {super.key});

  final initialRoute;

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Profixer Admin',
      theme: ThemeData(
          primaryColor: primaryColor,
          primarySwatch: const MaterialColor(
            0xFFF4891E,
            <int, Color>{
              50: Color.fromRGBO(244, 137, 30, 0.1), //10%
              100: Color.fromRGBO(244, 137, 30, 0.2), //20%
              200: Color.fromRGBO(244, 137, 30, 0.3), //30%
              300: Color.fromRGBO(244, 137, 30, 0.4), //40%
              400: Color.fromRGBO(244, 137, 30, 0.5), //50%
              500: Color.fromRGBO(244, 137, 30, 0.6), //60%
              600: Color.fromRGBO(244, 137, 30, 0.7), //70%
              700: Color.fromRGBO(244, 137, 30, 0.8), //80%
              800: Color.fromRGBO(244, 137, 30, 0.9), //90%
              900: Color.fromRGBO(244, 137, 30, 1), //100%
            },
          ),
          scaffoldBackgroundColor: backgroundColor,
          textTheme: GoogleFonts.poppinsTextTheme()),
      getPages: AppPages.routes,
      initialRoute: initialRoute,
      navigatorKey: alice.getNavigatorKey(),
      useInheritedMediaQuery: true,
      debugShowCheckedModeBanner: false,
    );
  }
}
