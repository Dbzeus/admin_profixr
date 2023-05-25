import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:profixer_admin/helpers/custom_colors.dart';
import 'package:profixer_admin/screens/city/city_controller.dart';
import 'package:profixer_admin/widgets/custom_appbar.dart';
import 'package:profixer_admin/widgets/custom_button.dart';
import 'package:profixer_admin/widgets/custom_edittext.dart';

class AddCityScreen extends StatelessWidget {
  final controller = Get.find<CityController>();

  AddCityScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.focusScope!.unfocus();
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: CustomAppBar(title: Get.arguments['title']),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 10,
              ),
              CustomEditText(
                  hintText: "City Name",
                  controller: controller.cityNameController),
              const SizedBox(
                height: 12,
              ),
              CustomEditText(
                hintText: "Service Category",
                controller: controller.countryNameController,
                suffixIcon: Obx(
                  () => DropdownButton(
                      value: controller.selectedCountry.value,
                      style: const TextStyle(color: blackColor, fontSize: 16),
                      underline: const SizedBox(),
                      isExpanded: true,
                      icon: const Icon(
                        Icons.keyboard_arrow_down,
                        color: blackColor,
                        size: 22,
                      ),
                      items: controller.countries.map((item) {
                        return DropdownMenuItem(
                          value: item,
                          child: Text(item['CountryName']),
                        );
                      }).toList(),
                      onChanged: (val) {
                        controller.selectedCountry(val);
                      }),
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              Obx(
                () => Row(
                  children: [
                    Expanded(child: Text('Status')),
                    Container(
                      width: 100,
                      height: 40,
                      color: controller.selectedIsActive.value
                          ? Colors.green.shade100
                          : Colors.grey.shade100,
                      child: Row(
                        children: [
                          Icon(Icons.done_rounded),
                          const SizedBox(
                            width: 8,
                          ),
                          Text('Active')
                        ],
                      ),
                    ),
                    Container(
                      width: 100,
                      height: 40,
                      color: !controller.selectedIsActive.value
                          ? Colors.red.shade100
                          : Colors.grey.shade100,
                      child: Row(
                        children: [
                          Icon(Icons.close),
                          const SizedBox(
                            width: 8,
                          ),
                          Text('Inactive')
                        ],
                      ),
                    )
                  ],
                ),
              ),
              const Spacer(),
              CustomButton(
                  text: Get.arguments['buttonTitle'],
                  onTap: () {
                    var city = {
                      "CityID": Get.arguments['city']['CityID'],
                      "CityName": controller.cityNameController.text.trim(),
                      "CountryID":
                          controller.selectedCountry.value['CountryID'],
                      "IsActive": controller.selectedIsActive.value,
                      "CUID": 0
                    };
                    controller.updateCity(
                        controller.selectedIsActive.value, city);
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
