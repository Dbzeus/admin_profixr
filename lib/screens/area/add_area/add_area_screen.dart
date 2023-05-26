import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:profixer_admin/helpers/constant_widgets.dart';
import 'package:profixer_admin/helpers/custom_colors.dart';
import 'package:profixer_admin/routes/app_routes.dart';
import 'package:profixer_admin/screens/area/area_controller.dart';
import 'package:profixer_admin/widgets/custom_appbar.dart';
import 'package:profixer_admin/widgets/custom_button.dart';
import 'package:profixer_admin/widgets/custom_edittext.dart';

class AddAreaScreen extends StatelessWidget {
  final controller = Get.find<AreaController>();

  AddAreaScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int areaId = -1;
    if (Get.arguments['area'] != null) {
      controller.areaNameController.text = Get.arguments['area']['AreaName'];
      controller.pincodeController.text = Get.arguments['area']['pincode'];
      controller.cityDropdownController.text =
          Get.arguments['area']['CityName'];
      areaId = Get.arguments['area']['AreaID'];
    } else {
      controller.areaNameController.clear();
      controller.pincodeController.clear();
      areaId = 0;
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
                  hintText: "Area Name",
                  controller: controller.areaNameController),
              const SizedBox(
                height: 10,
              ),
              CustomEditText(
                hintText: "Pincode",
                controller: controller.pincodeController,
                keyboardType: TextInputType.number,
              ),
              const SizedBox(
                height: 10,
              ),
              CustomEditText(
                hintText: "City ",
                controller: controller.cityDropdownController,
                suffixIcon: Obx(
                  () => DropdownButton(
                      value: controller.selectedCity.value,
                      style: const TextStyle(color: blackColor, fontSize: 16),
                      underline: const SizedBox(),
                      isExpanded: true,
                      icon: const Icon(
                        Icons.keyboard_arrow_down,
                        color: blackColor,
                        size: 22,
                      ),
                      items: controller.cities.map((item) {
                        return DropdownMenuItem(
                          value: item,
                          child: Text(item['CityName']),
                        );
                      }).toList(),
                      onChanged: (val) {
                        debugPrint(controller.selectedCity.toString());
                        controller.selectedCity(val);
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
                    var area = {
                      "AreaID": areaId,
                      "AreaName": controller.areaNameController.text.trim(),
                      "CityID":
                          controller.selectedCity.value['CountryID'],
                      "PinCode" : controller.pincodeController.text,
                      "IsActive": controller.selectedIsActive.value,
                      "CUID": 0
                    };
                    controller.updateArea(
                        controller.selectedIsActive.value, area);
                    controller.areaNameController.clear();
                    controller.cityDropdownController.clear();
                    Get.back();
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
