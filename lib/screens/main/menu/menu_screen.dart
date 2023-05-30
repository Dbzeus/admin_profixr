import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:profixer_admin/model/MenuResponse.dart';
import 'package:profixer_admin/routes/app_routes.dart';
import 'package:profixer_admin/widgets/custom_appbar.dart';

import '../../../helpers/custom_colors.dart';
import '../main_controller.dart';

class ProfixerMenuScreen extends StatelessWidget {
  final controller = Get.find<MainController>();

  ProfixerMenuScreen({Key? key}) : super(key: key);

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
      body: Obx(
        () => GridView.builder(
            padding:
                const EdgeInsets.symmetric(horizontal: 12, vertical: 32),
            itemCount: controller.menuData.length,
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 0.9,
                ),
            itemBuilder: (_, index) =>
                _buildMenu(controller.menuData[index])),
      ),
    );
  }

  _buildMenu(MenuData data) {
    return GestureDetector(
      onTap: () {
        Get.toNamed(data.actionName);
        //Get.toNamed(Routes.complaintNatureList);
      },
      child: Column(
        children: [
          CachedNetworkImage(imageUrl: data.icon,width: 70,height: 70,),
          const SizedBox(
            height: 12,
          ),
          Text(
            data.subMenu,
            textAlign: TextAlign.center,
            style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: primaryColor),
          ),
        ],
      ),
    );
  }

}
