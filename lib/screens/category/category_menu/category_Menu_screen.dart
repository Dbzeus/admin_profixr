import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:profixer_admin/helpers/custom_colors.dart';
import 'package:profixer_admin/routes/app_routes.dart';
import 'package:profixer_admin/widgets/custom_appbar.dart';

import 'category_Menu_controller.dart';

class CategoryMenuScreen extends GetView<CategoryMenuController> {
  final controller = Get.put(CategoryMenuController());

  CategoryMenuScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "Categories",
      ),
      body: ListView.builder(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemCount: controller.menu.length,
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
          physics: const BouncingScrollPhysics(),
          itemBuilder: (_, index) => _buildMenu(controller.menu[index])),

      floatingActionButton: FloatingActionButton(
          onPressed: () {
            Get.toNamed(Routes.addCategory,
                arguments: {
                  "title": "Add Category",
                  "buttonTitle" : "Add"
                });
          },
          elevation: 4,
          backgroundColor: primaryColor,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(8)),
          ),
          child: const Icon(
            Icons.add,
            color: whiteColor,
          )),
    );
  }

  _buildMenu(menu) {
    return GestureDetector(
      onTap: () {

        Get.toNamed(Routes.addCategory,
            arguments: {
              "title": "Edit Category",
              "buttonTitle" : "Save Changes"
            });
       /* if (menu["path"] != null) {
          Get.toNamed(menu['path']);
        }*/
      },
      child: Container(
        padding: const EdgeInsets.all(12),
        margin:  const EdgeInsets.symmetric(vertical: 6),
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
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SvgPicture.asset(
              menu["imagePath"],
              height: 50,
              width: 50,
            ),
            const SizedBox(
              width: 30,
            ),
            Expanded(
              child: Text(
                menu["title"],
                style: const TextStyle(
                    fontSize: 14, color: blackColor, fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(4)),
              child: Center(
                child: Icon(
                  Icons.delete,
                  size: 20,
                  color: whiteColor,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
