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
      // theme: lightTheme,
      //darkTheme: darkTheme,
      // themeMode: ThemeMode.system,
      getPages: AppPages.routes,
      initialRoute: initialRoute,
      navigatorKey: alice.getNavigatorKey(),
      useInheritedMediaQuery: true,
      debugShowCheckedModeBanner: false,
    );
  }
}
