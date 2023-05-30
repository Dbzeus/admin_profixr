import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:profixer_admin/helpers/custom_colors.dart';
import 'package:profixer_admin/routes/app_routes.dart';
import 'package:profixer_admin/widgets/custom_appbar.dart';

import '../area_controller.dart';

class AreaListScreen extends GetView<AreaController> {
  @override
  final controller = Get.put(AreaController());

  AreaListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "Area",
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 50,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: Colors.grey.shade100),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey.shade100,
                              spreadRadius: 1,
                              blurRadius: 3,
                              offset: const Offset(0, 2))
                        ]),
                    child: TextFormField(
                      controller: controller.searchController,
                      onChanged: (text){
                        controller.onSearchChanged(text);
                      },
                      style: const TextStyle(
                        fontSize: 16,
                        color: textColor,
                      ),
                      decoration: const InputDecoration(
                        hintText: 'Search',
                        border: InputBorder.none,
                        prefixIcon: Icon(
                          Icons.search,
                          color: textColor,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                GestureDetector(
                  onTap: () {
                    Get.toNamed(Routes.addArea, arguments: {
                      "title": "Add Area",
                      "buttonTitle": "Add",
                      "area": null,
                    });
                  },
                  child: Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: primaryColor,
                    ),
                    child: const Center(
                      child: Icon(
                        Icons.add,
                        color: whiteColor,
                      ),
                    ),
                  ),
                )
              ],
            ),
            Obx(
              () => Expanded(
                child: controller.isLoading.value
                    ? Center(child: const CircularProgressIndicator())
                    : controller.areas.isEmpty
                        ? Center(child: const Text('No Area Found'))
                        : ListView.builder(
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            itemCount: controller.areas.length,
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            physics: const BouncingScrollPhysics(),
                            itemBuilder: (_, index) =>
                                _buildCityTile(controller.areas[index])),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _buildCityTile(area) {
    return GestureDetector(
      onTap: () {
        Get.toNamed(Routes.addArea, arguments: {
          "title": "Edit Area",
          "buttonTitle": "Save Changes",
          "area": area,
        });
      },
      child: Container(
        padding: const EdgeInsets.all(12),
        margin: const EdgeInsets.symmetric(vertical: 6),
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
            Expanded(
              child: Row(
                children: [
                  Container(
                    width: 50,
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: primaryColor.withAlpha(30),
                    ),
                    child: Center(
                      child: Text(
                        (area["AreaName"].trim().split(" ") as List<String>)
                            .map((e) => e.trim().substring(0, 1).toUpperCase())
                            .join(""),
                        style: const TextStyle(
                          color: primaryColor,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 12,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        area["AreaName"],
                        style: const TextStyle(
                            fontSize: 14,
                            color: blackColor,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "${area["CityName"]},  ${area["pincode"]}",
                        style: const TextStyle(
                          fontSize: 12,
                          color: blackColor,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Switch(
                value: area["IsActive"],
                activeColor: Colors.green.shade200,
                inactiveThumbColor: Colors.red.shade200,
                onChanged: (val) {
                  controller.updateArea(val, area);
                })
          ],
        ),
      ),
    );
  }
}
