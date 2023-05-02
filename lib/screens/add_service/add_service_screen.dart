import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:profixer_admin/helpers/constant_widgets.dart';
import 'package:profixer_admin/helpers/custom_colors.dart';
import 'package:profixer_admin/screens/add_service/add_service_controller.dart';
import 'package:profixer_admin/widgets/custom_appbar.dart';
import 'package:profixer_admin/widgets/custom_button.dart';

import '../../widgets/custom_edittext.dart';

class AddServiceScreen extends GetView<AddServiceController> {
  @override
  final controller = Get.put(AddServiceController());

  AddServiceScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: CustomAppBar(
        widget: Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 8,vertical: 6),
            child: Row(
              children: [
                IconButton(
                    onPressed: () {
                      Get.back();
                    },
                    icon: const Icon(
                      Icons.arrow_back,
                      color: whiteColor,
                    )),
                const SizedBox(width: 12,),
                Text(
                  "Add Services",
                  style: TextStyle(
                      color: whiteColor, fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: SizedBox(
          height: MediaQuery.of(context).size.height * 0.868,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 10,
              ),
              CustomEditText(
                  hintText: "Service Name",
                  controller: controller.serviceNameController),
              const SizedBox(
                height: 10,
              ),
              CustomEditText(
                hintText: "Service Category",
                controller: controller.serviceCategoryController,
                suffixIcon: Obx(
                      () =>
                      DropdownButton(
                          value: controller.categoryDropDownValue.value,
                          style: const TextStyle(color: blackColor, fontSize: 16),
                          underline: const SizedBox(),
                          isExpanded: true,
                          icon: const Icon(
                            Icons.keyboard_arrow_down,
                            color: blackColor,
                            size: 22,
                          ),
                          items: controller.categoryItems.map((String items) {
                            return DropdownMenuItem(
                              value: items,
                              child: Text(items),
                            );
                          }).toList(),
                          onChanged: (val) {
                            controller.categoryDropDownValue(val.toString());
                          }),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              CustomEditText(
                hintText: "Service Amount",
                controller: controller.serviceAmountController,
                prefixIcon: Obx(
                  () => DropdownButton(
                      value: controller.dropDownValue.value,
                      style: const TextStyle(color: primaryColor, fontSize: 16),
                      underline: const SizedBox(),
                      icon: const Icon(
                        Icons.keyboard_arrow_down,
                        color: primaryColor,
                        size: 16,
                      ),
                      items: controller.items.map((String items) {
                        return DropdownMenuItem(
                          value: items,
                          child: Text(items),
                        );
                      }).toList(),
                      onChanged: (val) {
                        controller.dropDownValue(val.toString());
                      }),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              CustomEditText(
                hintText: "Service Description",
                controller: controller.serviceDescriptionController,
                maxLines: 6,
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                "Service Image",
                style: TextStyle(color: hintColor, fontSize: 12),
              ),
              const SizedBox(
                height: 20,
              ),
              uploadButton(),
              const Spacer(),
              CustomButton(
                  text: "Add",
                  onTap: () async{

                  })
            ],
          ),
        ),
      ),
    );
  }
}
