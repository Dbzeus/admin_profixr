import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:profixer_admin/helpers/custom_colors.dart';

import 'package:profixer_admin/widgets/custom_appbar.dart';

import '../../routes/app_routes.dart';
import 'category_Menu_controller.dart';

class CategoryMenuScreen extends GetView<CategoryMenuController> {
  final controller = Get.put(CategoryMenuController());

  CategoryMenuScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        widget: const Padding(
          padding: EdgeInsets.only(bottom: 8.0),
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Text(
              "Categories",
              style: TextStyle(
                  color: whiteColor, fontSize: 18, fontWeight: FontWeight.bold),
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
              childAspectRatio: 1.5,
              mainAxisSpacing: 10),
          itemBuilder: (_, index) => _buildMenu(controller.menu[index])),
    );
  }

  _buildMenu(menu) {
    return GestureDetector(
      onTap: () {
        if(menu["title"] == "Add Categories"){
          Get.toNamed(Routes.addCategory);
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
                  fontSize: 16, color: blackColor),
            ),
          ],
        ),
      ),
    );
  }
}
