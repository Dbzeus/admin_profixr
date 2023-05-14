
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:profixer_admin/helpers/constant_widgets.dart';
import 'package:profixer_admin/helpers/custom_colors.dart';
import 'package:profixer_admin/routes/app_routes.dart';
import 'package:profixer_admin/screens/techinican_details/techinician_details_controller.dart';
import 'package:profixer_admin/widgets/custom_appbar.dart';
import 'package:profixer_admin/widgets/custom_button.dart';
import 'package:profixer_admin/widgets/custom_edittext.dart';

class TechnicianDetailsScreen extends GetView<TechnicianDetailsController> {

  @override
  final controller= Get.put(TechnicianDetailsController());
   TechnicianDetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Get.focusScope!.unfocus();
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: CustomAppBar(
          title: "Personal Details"
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              CustomEditText(
                  hintText: "Name",
                  controller: controller.nameController),
              const SizedBox(
                height: 10,
              ),
              CustomEditText(
                hintText: "Mobile Number",
                controller: controller.mobileController,
                prefixIcon: Obx(
                      () => DropdownButton(
                      value: controller.mobileNoDropDownValue.value,
                      style: const TextStyle(
                          color: primaryColor, fontSize: 16),
                      underline: const SizedBox(),
                      icon: const Icon(
                        Icons.keyboard_arrow_down,
                        color: primaryColor,
                        size: 16,
                      ),
                      items: controller.mobileItems.map((String items) {
                        return DropdownMenuItem(
                          value: items,
                          child: Text(items),
                        );
                      }).toList(),
                      onChanged: (val) {
                        controller.mobileNoDropDownValue(val.toString());
                      }),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              CustomEditText(
                hintText: "Email",
                controller: controller.emailController,
              ),
              const SizedBox(
                height: 10,
              ),
              CustomEditText(
                hintText: "Gender",
                controller: controller.genderController,
                suffixIcon: Obx(
                      () => DropdownButton(
                      value: controller.genderDropDownValue.value,
                      style:
                      const TextStyle(color: blackColor, fontSize: 16),
                      underline: const SizedBox(),
                      isExpanded: true,
                      icon: const Icon(
                        Icons.keyboard_arrow_down,
                        color: blackColor,
                        size: 22,
                      ),
                      items: controller.genderItems.map((String items) {
                        return DropdownMenuItem(
                          value: items,
                          child: Text(items),
                        );
                      }).toList(),
                      onChanged: (val) {
                        controller.genderDropDownValue(val.toString());
                      }),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              CustomEditText(
                hintText: "Identity Proof Number",
                controller: controller.identityController,
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Proof Photo Copy",
                    style: TextStyle(color: hintColor, fontSize: 12),
                  ),
                  Icon(Icons.verified,
                  color: Colors.green,)
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              uploadButton(),
              const SizedBox(
                height:20,
              ),
              CustomEditText(
                hintText: "Occupation",
                controller: controller.occupationController,
                suffixIcon: Obx(
                      () => DropdownButton(
                      value: controller.occupationDropDownValue.value,
                      style:
                      const TextStyle(color: blackColor, fontSize: 16),
                      underline: const SizedBox(),
                      isExpanded: true,
                      icon: const Icon(
                        Icons.keyboard_arrow_down,
                        color: blackColor,
                        size: 22,
                      ),
                      items: controller.occupationItems.map((String items) {
                        return DropdownMenuItem(
                          value: items,
                          child: Text(items),
                        );
                      }).toList(),
                      onChanged: (val) {
                        controller.occupationDropDownValue(val.toString());
                      }),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              CustomEditText(
                hintText: "PAN No",
                controller: controller.panController,
              ),
              const SizedBox(
                height: 10,
              ),
              CustomEditText(
                hintText: "Permanent Address",
                controller: controller.permanentAddressController,
              ),
              const SizedBox(
                height:10,
              ),
              CustomEditText(
                hintText: "City",
                controller: controller.cityController,
                suffixIcon: Obx(
                      () => DropdownButton(
                      value: controller.cityDropDownValue.value,
                      style:
                      const TextStyle(color: blackColor, fontSize: 16),
                      underline: const SizedBox(),
                      isExpanded: true,
                      icon: const Icon(
                        Icons.keyboard_arrow_down,
                        color: blackColor,
                        size: 22,
                      ),
                      items: controller.cityItems.map((String items) {
                        return DropdownMenuItem(
                          value: items,
                          child: Text(items),
                        );
                      }).toList(),
                      onChanged: (val) {
                        controller.cityDropDownValue(val.toString());
                      }),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              CustomEditText(
                hintText: "Current Address",
                controller: controller.currentAddressController,
              ),
              const SizedBox(
                height: 30,
              ),
              Row(
                children: [
                  Obx(()=>
                     Checkbox(value: controller.checkValue.value, onChanged: (value){
                      controller.checkValue(value);
                    }),
                  ),
                  Expanded(
                    child: RichText(
                        maxLines: 3,

                        text: const TextSpan(
                      style: TextStyle(
                          color: textColor,

                      ),
                      children: [
                        TextSpan(text: " By tapping, you accept our"),
                        TextSpan(text: " terms ",style: TextStyle(
                            color: primaryColor,

                        ),),
                        TextSpan(text: " and "),
                        TextSpan(text: " conditions ",style: TextStyle(
                            color: primaryColor,


                        ),),
                      ]
                    )),
                  ),

                ],
              ),
              const SizedBox(
                height: 10,
              ),
              CustomButton(
                text: "Next",
                btnColor: blackColor,
                onTap: (){
                  Get.toNamed(Routes.bankDetails);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
