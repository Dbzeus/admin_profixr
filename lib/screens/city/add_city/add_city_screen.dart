import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:profixer_admin/helpers/custom_colors.dart';
import 'package:profixer_admin/screens/city/city_controller.dart';
import 'package:profixer_admin/widgets/custom_appbar.dart';
import 'package:profixer_admin/widgets/custom_button.dart';
import 'package:profixer_admin/widgets/custom_edittext.dart';
import 'package:profixer_admin/widgets/custom_loader.dart';

import '../../../helpers/utils.dart';
import '../../../widgets/custom_dropdown.dart';

class AddCityScreen extends StatelessWidget {
  final controller = Get.find<CityController>();

  AddCityScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int cityId = 0;

    if (Get.arguments['city'] != null) {
      controller.cityNameController.text = Get.arguments['city']['CityName'];
      controller.selectedCountry('${Get.arguments['city']['CountryID']}');
      cityId = Get.arguments['city']['CityID'];
      controller.selectedIsActive(Get.arguments['city']['IsActive']);
    }else{
      controller.selectedCountry(null);
      controller.cityNameController.clear();
      controller.selectedIsActive(true);
    }

    return GestureDetector(
      onTap: () {
        Get.focusScope!.unfocus();
      },
      child: Stack(
        children: [
          Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: CustomAppBar(title: Get.arguments['title']),
            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 12,
                  ),
                  CustomEditText(
                      hintText: "City Name",
                      controller: controller.cityNameController),
                  const SizedBox(
                    height: 24,
                  ),
                  Obx(
                    () => CustomDropDown(
                      hintText: "Country",
                      dropDownValue: controller.selectedCountry.value,
                      items: controller.countries,
                      onSelected: (val) {
                        controller.selectedCountry(val);
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 32,
                  ),
                  Obx(
                    () => Row(
                      children: [
                        const Expanded(child: Text('Status')),
                        InkWell(
                          onTap: () {
                            if(controller.selectedIsActive.value==false) {
                              controller.selectedIsActive(
                                  !controller.selectedIsActive.value);
                            }
                          },
                          child: Container(
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
                                  color: controller.selectedIsActive.value
                                      ? Colors.green
                                      : Colors.black54,
                                ),
                                const SizedBox(
                                  width: 8,
                                ),
                                Text(
                                  'Active',
                                  style: TextStyle(
                                    color: controller.selectedIsActive.value
                                        ? Colors.green
                                        : Colors.black54,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 12,
                        ),
                        InkWell(
                          onTap: () {
                            if(controller.selectedIsActive.value==false) {
                              controller.selectedIsActive(
                                  !controller.selectedIsActive.value);
                            }
                          },
                          child: Container(
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
                                Icon(
                                  Icons.close,
                                  size: 16,
                                  color: !controller.selectedIsActive.value
                                      ? Colors.red
                                      : Colors.black54,
                                ),
                                const SizedBox(
                                  width: 8,
                                ),
                                Text(
                                  'Inactive',
                                  style: TextStyle(
                                    color: !controller.selectedIsActive.value
                                        ? Colors.red
                                        : Colors.black54,
                                  ),
                                )
                              ],
                            ),
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
                          "CountryID": controller.selectedCountry.value,
                          "IsActive": controller.selectedIsActive.value,
                          "CUID": controller.box.read(Session.userId)
                        };
                        controller.createCity(city,Get.arguments['city'] != null);
                      }),
                ],
              ),
            ),
          ),
          Obx(()=> controller.isLoading.value ? CustomLoader() : const SizedBox.shrink())
        ],
      ),
    );
  }
}
