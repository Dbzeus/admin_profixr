import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:profixer_admin/routes/app_routes.dart';
import 'package:profixer_admin/widgets/custom_appbar.dart';
import '../menu/menu_controller.dart';
import '../../../helpers/custom_colors.dart';

class ProfixrMenuScreen extends GetView<ProfixrMenuController> {
  final controller = Get.put(ProfixrMenuController());

  ProfixrMenuScreen({Key? key}) : super(key: key);

  List menu = [
    {
      "title": "Services",
      "imagePath": 'assets/icon/menu/serviceicon.png',
      "path": Routes.serviceMenu,
    },
    {
      "title": "Category",
      "imagePath": 'assets/icon/menu/category.png',
      "path": Routes.categoryMenu,
    },
    {
      "title": "Profixers",
      "imagePath": 'assets/icon/menu/profixer.png',
    },
    {
      "title": "Customer",
      "imagePath": 'assets/icon/menu/customer.png',
    },
    {
      "title": "Service Provider",
      "imagePath": 'assets/icon/menu/serviceprovider.png',
    },
    {
      "title": "Technician",
      "imagePath": 'assets/icon/menu/technician.png',
      "path": Routes.technicianDetails,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "Menu",
        bgColor: whiteColor,
        textColor: blackColor,
        iconColor: blackColor,
        showShadow: true,
        isHaveLeading: false,
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 12,
          ),
          GridView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
              itemCount: controller.menuData.length,
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              physics: const BouncingScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 10,
                  childAspectRatio: 1.3,
                  mainAxisSpacing: 10),
              itemBuilder: (_, index) => _buildMenu(controller.menuData)),

        ],
      ),
    );
  }


  _buildMenu2(){
    return GestureDetector(
      onTap: (){},
      child: Container(

        width: 110,
        color: Colors.blue,
        child: Column(
          children: [
            const CircleAvatar(
              backgroundImage: CachedNetworkImageProvider('https://lh3.googleusercontent.com/ogw/AOLn63FrRz1Sj7YR6k9tIBht1Hp_Xbr2osMhWRMybXZDRg=s32-c-mo'),
              backgroundColor: Colors.white,
              radius: 50,

            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              "Demo",
              style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: primaryColor),
            ),
          ],
        ),
      ),
    );

  }

  _buildMenu(menu) {
    return GestureDetector(
      onTap: () {
        pageRoute(menu);
      },
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
            color: cardBgColor,
            border: Border.all(color: Colors.grey.shade100),
            boxShadow: [
              BoxShadow(
                  color: Colors.grey.shade100,
                  spreadRadius: 1,
                  blurRadius: 3,
                  offset: const Offset(0, 2))
            ],
            borderRadius: BorderRadius.circular(16)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              menu["title"],
              style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: primaryColor),
            ),
            const Spacer(),
            Align(
              alignment: Alignment.centerRight,
              child: Image.asset(
                menu["imagePath"],
                height: 75,
                width: 70,
                fit: BoxFit.cover,
              ),
            ),
            // Align(
            //   alignment: Alignment.centerRight,
            //   child: SvgPicture.asset(
            //     'assets/icon/service.svg',
            //     height: 40,
            //     width: 25,
            //   ),
            // ),
          ],
        ),
      ),
    );
  }

  pageRoute(menu) {
    if (menu["path"] != null) {
      Get.toNamed(
        menu["path"],
      );
    }
  }
}
