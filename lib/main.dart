import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:profixer_admin/helpers/custom_colors.dart';
import 'package:profixer_admin/routes/app_pages.dart';
import 'package:profixer_admin/routes/app_routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //check session
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Profixer Admin',
      theme: ThemeData(
          primaryColor: primaryColor,
          scaffoldBackgroundColor: backgroundColor,
          textTheme: GoogleFonts.poppinsTextTheme()),
      getPages: AppPages.routes,
      initialRoute: Routes.Language,
      useInheritedMediaQuery: true,
      debugShowCheckedModeBanner: false,
    );
  }
}
