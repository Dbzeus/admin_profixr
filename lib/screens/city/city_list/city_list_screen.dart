import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:profixer_admin/helpers/custom_colors.dart';
import 'package:profixer_admin/routes/app_routes.dart';
import 'package:profixer_admin/widgets/custom_appbar.dart';

import '../city_controller.dart';

class CityListScreen extends GetView<CityController> {
  @override
  final controller = Get.put(CityController());

  CityListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: CustomAppBar(
        title: "City",
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
                        borderRadius: BorderRadius.circular(12),
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
                    controller.searchController.clear();
                    Get.toNamed(Routes.addCity,
                        arguments: {"title": "Add City", "buttonTitle": "Add","city": null,});
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
                    ? const Center(child: CircularProgressIndicator())
                    : controller.cities.isEmpty
                    ? const Center(child: Text('No Cities Found'))
                    :ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: controller.cities.length,
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (_, index) =>
                        _buildCityTile(controller.cities[index])),
              ),
            ),
          ],
        ),
      ),

    );
  }

  _buildCityTile(city) {
    return GestureDetector(
      onTap: () {
        controller.searchController.clear();
        Get.toNamed(Routes.addCity, arguments: {
          "title": "Edit City",
          "buttonTitle": "Save Changes",
          "city": city,
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
                    width:50,
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: primaryColor.withAlpha(30),
                    ),
                    child: Center(
                      child: Text(
                        city["CityName"].trim().substring(0,2).toUpperCase(),
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
                        city["CityName"],
                        style: const TextStyle(
                            fontSize: 14,
                            color: blackColor,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        city["CountryName"],
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
                value: city["IsActive"],
                activeColor: Colors.green.shade200,
                inactiveThumbColor: Colors.red.shade200,
                onChanged: (val) {
                  controller.updateCity(val, city);
                })
          ],
        ),
      ),
    );
  }
}
