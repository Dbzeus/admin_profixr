import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:profixer_admin/helpers/constant_widgets.dart';
import 'package:profixer_admin/helpers/custom_colors.dart';
import 'package:profixer_admin/routes/app_routes.dart';
import 'package:profixer_admin/screens/city/city_controller.dart';
import 'package:profixer_admin/widgets/cusotm_alertdialogue.dart';
import 'package:profixer_admin/widgets/custom_appbar.dart';
import 'package:profixer_admin/widgets/custom_button.dart';
import 'package:profixer_admin/widgets/custom_edittext.dart';

class AddCityScreen extends StatelessWidget {
  final controller = Get.find<CityController>();

  AddCityScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int cityId = -1;
    if(Get.arguments['city'] != null){
      controller.cityNameController.text = Get.arguments['city']['CityName'];
      controller.countryNameController.text =
          Get.arguments['city']['CountryName'];
       cityId= Get.arguments['city']['CityID'];
    }else{
      controller.cityNameController.text = " ";
      cityId =0;
    }


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
                hintText: "country Name",
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
                    const Expanded(child: Text('Status')),
                    Container(
                      width: 100,
                      height: 40,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: controller.selectedIsActive.value
                            ? greenColor
                            : Colors.grey.shade100,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.done_rounded,
                            size: 16,
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          Text(
                            'Active',
                            style: TextStyle(
                              color: controller.selectedIsActive.value
                                  ? Colors.green
                                  : Colors.grey.shade100,
                            ),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      width: 12,
                    ),
                    Container(
                      width: 100,
                      height: 40,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: !controller.selectedIsActive.value
                            ? Colors.red.shade100
                            : Colors.grey.shade100,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.close,
                            size: 16,
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          Text(
                            'Inactive',
                            style: TextStyle(
                              color: controller.selectedIsActive.value
                                  ? Colors.red
                                  : Colors.grey.shade100,
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              CustomButton(
                  text: Get.arguments['buttonTitle'],
                  onTap: () {
                    var city = {
                      "CityID": cityId,
                      "CityName": controller.cityNameController.text.trim(),
                      "CountryID":
                          controller.selectedCountry.value['CountryID'],
                      "IsActive": controller.selectedIsActive.value,
                      "CUID": 0
                    };
                    controller.updateCity(
                        controller.selectedIsActive.value, city);
                    controller.cityNameController.clear();
                    controller.countryNameController.clear();
                    Get.back();

                  }),
            ],
          ),
        ),
      ),
    );
  }
}
