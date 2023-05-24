import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:profixer_admin/helpers/custom_colors.dart';
import 'package:profixer_admin/screens/main/menu/menu_screen.dart';
import 'package:profixer_admin/screens/main/profile/profile_screen.dart';

import 'home/home_screen.dart';

class MainScreen extends StatelessWidget {
  MainScreen({Key? key}) : super(key: key);

  var pages=[
    HomeScreen(),
    ProfixrMenuScreen(),
    ProfileScreen(),
  ];

  RxInt index=0.obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(()=>pages[index.value],),
      bottomNavigationBar: Obx(()=>BottomNavigationBar(
          elevation: 12,
          selectedFontSize: 12,
          unselectedFontSize: 12,
          showUnselectedLabels: false,
          selectedItemColor: blackColor,
          unselectedItemColor: hintColor,
          backgroundColor: primaryColor,
          currentIndex: index.value,
          onTap: (i)=>index(i),
          items: [
        BottomNavigationBarItem(icon: SvgPicture.asset('assets/icon/menu/home.svg',width: 20,height: 20,color: index.value==0 ? blackColor : Colors.white,),label: "Home",),
        BottomNavigationBarItem(icon: SvgPicture.asset('assets/icon/menu/shop.svg',width: 20,height: 20,color: index.value==1 ? blackColor : Colors.white,),label: "Job"),
        BottomNavigationBarItem(icon: SvgPicture.asset('assets/icon/menu/profile.svg',width: 20,height: 20,color: index.value==2 ? blackColor : Colors.white,),label: "Profile"),
      ]),),
    );
  }
}
