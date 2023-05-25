import 'package:flutter/material.dart';
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
      appBar: CustomAppBar(
        title: "City",
      ),
      body: ListView.builder(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemCount: controller.cities.length,
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
          physics: const BouncingScrollPhysics(),
          itemBuilder: (_, index) => _buildCityTile(controller.cities[index])),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            Get.toNamed(Routes.addCity,
                arguments: {"title": "Add City", "buttonTitle": "Add"});
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

  _buildCityTile(city) {
    return GestureDetector(
      onTap: () {
        Get.toNamed(Routes.addCategory, arguments: {
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
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: primaryColor.withAlpha(30),
              ),
              child: Text(
                city["CityName"]
                    .split(" ")
                    .map((e) => e.substring(0, 0).toUpperCase())
                    .toString(),
                style: const TextStyle(
                  color: primaryColor,
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(
              width: 24,
            ),
            Expanded(
              child: Column(
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
            ),
            Switch(
                value: city["IsActive"],
                onChanged: (val) {
                  controller.updateCity(val, city);
                })
          ],
        ),
      ),
    );
  }
}
