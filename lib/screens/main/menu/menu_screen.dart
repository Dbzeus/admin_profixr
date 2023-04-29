import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:profixer_admin/routes/app_routes.dart';

import '../../../helpers/custom_colors.dart';

class MenuScreen extends StatelessWidget {
   MenuScreen({Key? key}) : super(key: key);

List menu = [
  {"title" : "Services",
  "imagePath" : 'assets/icon/menu/serviceicon.png',
  },
  {"title" : "Category",
    "imagePath" : 'assets/icon/menu/serviceicon.png',
  },
  {"title" : "New Ticket",
    "imagePath" : 'assets/icon/menu/serviceicon.png',
  },
  {"title" : "Technician",
    "imagePath" : 'assets/icon/menu/serviceicon.png',
  },
  {"title" : "Customer",
    "imagePath" : 'assets/icon/menu/serviceicon.png',
  },
];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(height: 40,),
          const Text(
            'Menu',
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
          ),
          const SizedBox(height: 12,),
          GridView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
              itemCount: menu.length,
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              physics: const BouncingScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  childAspectRatio: 1.5,
                  mainAxisSpacing: 10),
              itemBuilder: (_, index) => _buildMenu(menu[index])),

        ],
      ),
    );
  }

  _buildMenu(menu) {
    return GestureDetector(
      onTap: (){

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
                  fontSize: 16, fontWeight: FontWeight.bold, color: primaryColor),
            ),
            const Spacer(),
            Align(
              alignment: Alignment.centerRight,
              child: Image.asset(
               menu["imagePath"] ,

                height: 65,
                width: 50,
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
    if(menu["title"] == "Services"){
      Get.toNamed(
        Routes.serviceMenu,
      );
    }else if(menu["title"] == "Category"){
      Get.toNamed(
        Routes.categoryMenu,
      );
    }else if(menu["title"] == "New Ticket"){
      Get.toNamed(
        Routes.newTicket,
      );
    }
  }
}
