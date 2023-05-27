import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:profixer_admin/helpers/custom_colors.dart';
import 'package:profixer_admin/helpers/utils.dart';
import 'package:profixer_admin/screens/area/area_controller.dart';
import 'package:profixer_admin/widgets/custom_appbar.dart';
import 'package:profixer_admin/widgets/custom_button.dart';
import 'package:profixer_admin/widgets/custom_edittext.dart';

import '../../../widgets/custom_dropdown.dart';

class AddAreaScreen extends StatelessWidget {
  final controller = Get.find<AreaController>();

  AddAreaScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int areaId = 0;
    if (Get.arguments['area'] != null) {
      controller.areaNameController.text = Get.arguments['area']['AreaName'];
      controller.pincodeController.text = Get.arguments['area']['pincode'];
      controller.selectedCity('${Get.arguments['area']['CityID']}');
      areaId = Get.arguments['area']['AreaID'];
      controller.selectedIsActive(Get.arguments['area']['IsActive']);
    }else{
      controller.areaNameController.clear();
      controller.pincodeController.clear();
      controller.selectedIsActive(true);
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
                height: 12,
              ),
              CustomEditText(
                  hintText: "Area Name",
                  controller: controller.areaNameController),
              const SizedBox(
                height: 24,
              ),
              CustomEditText(
                hintText: "Pincode",
                controller: controller.pincodeController,
                keyboardType: TextInputType.number,
              ),
              const SizedBox(
                height: 24,
              ),
              Obx(
                () => CustomDropDown(
                  hintText: "City",
                  dropDownValue: controller.selectedCity.value,
                  items: controller.cities,
                  onSelected: (val) {
                    controller.selectedCity(val);
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

                      child: AnimatedContainer(
                        width: 100,
                        height: 40,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: controller.selectedIsActive.value
                              ? greenColor
                              : Colors.grey.shade100,
                        ),
                        duration: Duration(milliseconds: 100),

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
                      onTap: (){
                        if(controller.selectedIsActive.value==true) {
                          controller.selectedIsActive(
                              !controller.selectedIsActive.value);
                        }
                      },
                      child: AnimatedContainer(
                        width: 100,
                        height: 40,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: !controller.selectedIsActive.value
                              ? Colors.red.shade100
                              : Colors.grey.shade100,
                        ),
                        duration: Duration(milliseconds: 100),
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
                    var area = {
                      "AreaID": areaId,
                      "AreaName": controller.areaNameController.text.trim(),
                      "CityID": controller.selectedCity.value,
                      "PinCode": controller.pincodeController.text,
                      "IsActive": controller.selectedIsActive.value,
                      "CUID": controller.box.read(Session.userId)
                    };
                    controller.createArea(area,Get.arguments['area'] != null);
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
