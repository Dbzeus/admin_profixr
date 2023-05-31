
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:profixer_admin/helpers/constant_widgets.dart';
import 'package:profixer_admin/helpers/custom_colors.dart';
import 'package:profixer_admin/routes/app_routes.dart';
import 'package:profixer_admin/screens/technician/technician_controller.dart';


import 'package:profixer_admin/widgets/custom_appbar.dart';
import 'package:profixer_admin/widgets/custom_button.dart';
import 'package:profixer_admin/widgets/custom_edittext.dart';

import '../../../widgets/custom_dropdown.dart';



class AddTechnicianScreen extends StatelessWidget {

  @override
  final controller= Get.find<TechnicianController>();
   AddTechnicianScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Get.focusScope!.unfocus();
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: CustomAppBar(
          title: "Add Technician"
        ),
        body: Obx(()=>
           Stack(
            children: [
              controller.isConfirm.value ?
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    CustomEditText(
                        hintText: "First Name",
                        controller: controller.firstNameController),
                    const SizedBox(
                      height: 10,
                    ),
                    CustomEditText(
                        hintText: "Last Name",
                        controller: controller.lastNameController),
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
                      hintText: "Date of Birth",
                      showCursor: false,
                      keyboardType: TextInputType.none,
                      controller: controller.dobController,
                      suffixIcon: const Icon(
                        Icons.calendar_month_rounded,
                        color: blackColor,
                        size: 22,
                      ),
                      onTab: () async {
                        var date = await showDatePicker(
                            context: Get.context!,
                            initialDate: DateTime.now(),
                            firstDate: DateTime.now(),
                            lastDate: DateTime(DateTime.now().year + 1, 12, 31));
                        if (date != null) {
                          debugPrint(date.toString());
                          controller.dobController.text =
                              DateFormat(controller.dateFormat).format(date);
                        }
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    CustomEditText(
                      hintText: "Username",
                      controller: controller.userNameController,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    CustomEditText(
                      hintText: "Create Password",
                      controller: controller.passwordController,
                    ),
                    const Spacer(),
                    CustomButton(
                      text: "Next",
                      btnColor: blackColor,
                      onTap: (){
                        controller.isConfirm.value ? controller.isConfirm(false) :
                        Get.toNamed(Routes.bankDetails);
                      },
                    ),
                  ],
                ),
              ):
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
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
                    Obx(() => controller.imagePath.value.isNotEmpty
                        ? Container(
                      height: 150,
                      decoration: BoxDecoration(
                        image: DecorationImage(image: FileImage(File(controller.imagePath.value)),fit: BoxFit.cover),
                        borderRadius: BorderRadius.circular(8),
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.transparent,
                            Colors.black12,
                            Colors.black54,
                            Colors.black87
                          ],
                        ),
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 8,vertical: 8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          GestureDetector(
                              onTap: () {
                                controller.imagePath("");
                              },
                              child: Icon(Icons.close,color: Colors.white,)),
                          const Spacer(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Icon(Icons.remove_red_eye_outlined,size: 14,color: Colors.white,),
                              const SizedBox(width: 4,),
                              Text('Preview',style: TextStyle(color: Colors.white,fontSize: 12),)
                            ],
                          )
                        ],
                      ),
                    )
                        : const SizedBox()),
                    const SizedBox(
                      height: 20,
                    ),
                    uploadButton(() async {
                      controller.imagePath(await getImageFromGallery() ?? controller.imagePath.value);
                    }),
                    const SizedBox(
                      height:20,
                    ),
                    CustomEditText(
                      hintText: "Occupation",
                      controller: controller.occupationController,
                      suffixIcon: Obx(
                            () => DropdownButton(
                            value: controller.serviceProviderDropDownValue.value,
                            style:
                            const TextStyle(color: blackColor, fontSize: 16),
                            underline: const SizedBox(),
                            isExpanded: true,
                            icon: const Icon(
                              Icons.keyboard_arrow_down,
                              color: blackColor,
                              size: 22,
                            ),
                            items: controller.serviceProviderDropDownItems.map((String items) {
                              return DropdownMenuItem(
                                value: items,
                                child: Text(items),
                              );
                            }).toList(),
                            onChanged: (val) {
                              controller.serviceProviderDropDownValue(val.toString());
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
                        controller.isConfirm.value ? controller.isConfirm(false) :
                        Get.toNamed(Routes.bankDetails);
                      },
                    ),
                  ],
                ),
              ),



            ],
          ),
        ),
      ),
    );
  }
}
