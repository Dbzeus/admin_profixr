import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:profixer_admin/helpers/custom_colors.dart';
import 'package:profixer_admin/widgets/custom_appbar.dart';

import 'category_Menu_controller.dart';

class CategoryMenuScreen extends GetView<CategoryMenuController> {
  final controller = Get.put(CategoryMenuController());

  CategoryMenuScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        widget: Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 8,vertical: 6),
            child: Row(
              children: [
                IconButton(
                    onPressed: () {
                      Get.back();
                    },
                    icon: const Icon(
                      Icons.arrow_back,
                      color: whiteColor,
                    )),
                Text(
                  "Categories",
                  style: TextStyle(
                      color: whiteColor, fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ),
      ),
      body: GridView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
          itemCount: controller.menu.length,
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          physics: const BouncingScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              childAspectRatio: 1.4,
              mainAxisSpacing: 10),
          itemBuilder: (_, index) => _buildMenu(controller.menu[index])),
    );
  }

  _buildMenu(menu) {
    return GestureDetector(
      onTap: () {
        if(menu["path"]!=null){
          Get.toNamed(menu['path']);
        }

      },
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
            color: Colors.white,
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
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
        SvgPicture.asset(
              menu["imagePath"],
            height: 50,
           width: 50,
             ),
            const Spacer(),
             Text(
              menu["title"],
              style: const TextStyle(
                  fontSize: 14, color: blackColor,fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
