import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:profixer_admin/helpers/custom_colors.dart';
import 'package:profixer_admin/screens/main/main_controller.dart';
import 'package:profixer_admin/screens/main/menu/menu_screen.dart';
import 'package:profixer_admin/screens/main/profile/profile_screen.dart';

import 'home/home_screen.dart';

class MainScreen extends GetView<MainController> {
  MainScreen({Key? key}) : super(key: key);

  @override
  final controller = Get.put(MainController());

  var pages = [
    HomeScreen(),
    ProfixerMenuScreen(),
    ProfileScreen(),
  ];

  RxInt index = 0.obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => pages[index.value],
      ),
      /*bottomNavigationBar: Obx(() => Container(
            width: MediaQuery.of(context).size.width,
            height: 65,
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12), color: primaryColor),
            child: Row(
              children: [
                Expanded(
                  child: SvgPicture.asset(
                    'assets/icon/menu/home.svg',
                    width: 20,
                    height: 20,
                    color: Colors.white,
                  ),
                ),
                Expanded(
                  child: SvgPicture.asset(
                    'assets/icon/menu/shop.svg',
                    width: 20,
                    height: 20,
                    color: Colors.white,
                  ),
                ),
                Expanded(
                  child: SvgPicture.asset(
                    'assets/icon/menu/profile.svg',
                    width: 20,
                    height: 20,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          )),*/
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
            elevation: 12,
            selectedFontSize: 12,
            unselectedFontSize: 12,
            showUnselectedLabels: false,
            selectedItemColor: blackColor,
            unselectedItemColor: hintColor,
            backgroundColor: primaryColor,
            currentIndex: index.value,
            onTap: (i) => index(i),
            showSelectedLabels: false,
            items: [
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  'assets/icon/menu/home.svg',
                  width: 20,
                  height: 20,
                  color: index.value == 0 ? blackColor : Colors.white,
                ),
                label:"",
              ),
              BottomNavigationBarItem(
                  icon: SvgPicture.asset(
                'assets/icon/menu/shop.svg',
                width: 20,
                height: 20,
                color: index.value == 1 ? blackColor : Colors.white,
              ),label:"",),
              BottomNavigationBarItem(
                  icon: SvgPicture.asset(
                'assets/icon/menu/profile.svg',
                width: 20,
                height: 20,
                color: index.value == 2 ? blackColor : Colors.white,
              ),label:"",),
            ]),
      ),
    );
  }
}
