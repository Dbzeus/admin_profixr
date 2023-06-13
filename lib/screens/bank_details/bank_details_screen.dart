
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:profixer_admin/helpers/constant_widgets.dart';
import 'package:profixer_admin/helpers/custom_colors.dart';
import 'package:profixer_admin/screens/bank_details/bank_details_controller.dart';
import 'package:profixer_admin/widgets/custom_appbar.dart';
import 'package:profixer_admin/widgets/custom_button.dart';
import 'package:profixer_admin/widgets/custom_edittext.dart';

import '../../helpers/utils.dart';

class BankDetailsScreen extends GetView<BankDetailsController> {

  @override
  final controller= Get.put(BankDetailsController());
   BankDetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Get.focusScope!.unfocus();
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: CustomAppBar(
            title: "Bank Details"
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomEditText(
                  hintText: "Name (as Registered in Bank)",
                  controller: controller.nameController),
              const SizedBox(
                height: 10,
              ),
              CustomEditText(
                hintText: "Bank Account Number",
                controller: controller.accountNoController,
                keyboardType: TextInputType.number,
              ),
              const SizedBox(
                height: 10,
              ),
              CustomEditText(
                hintText: "Confirm Bank Number",
                controller: controller.confirmAccountNoController,
                keyboardType: TextInputType.number,
                obscureText: true,
              ),
              const SizedBox(
                height: 10,
              ),
              CustomEditText(
                hintText: "IFSC Number",
                controller: controller.ifscNoController,
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                "Cancelled Cheque or Passbook",
                style: TextStyle(color: hintColor, fontSize: 12),
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
              Row(
                children: [
                  Expanded(
                    child: Obx(() => InkWell(
                      onTap: (){
                        if(controller.imagePath.value.isNotEmpty){
                          open(Get.context!, 0, [controller.imagePath.value]);
                        }
                      },
                      child: DottedBorder(
                        color: controller.imagePath.value.isNotEmpty
                            ? primaryColor
                            : Colors.black26,
                        strokeWidth: 1,
                        child: Container(
                            height: 50,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: controller
                                      .imagePath.value.isURL
                                      ? CachedNetworkImage(
                                      imageUrl: controller
                                          .imagePath
                                          .value) as ImageProvider
                                      : FileImage(File(controller
                                      .imagePath.value)),
                                  fit: BoxFit.cover),
                            ),
                            child: controller.imagePath.value.isEmpty
                                ? const Center(
                                child: Text('Upload images'))
                                : const SizedBox(width: double.infinity,height: double.infinity,)),
                      ),
                    )),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Column(
                    children: [
                      Row(
                        children: [
                          InkWell(
                            onTap: () async {
                              controller.imagePath(
                                  await getImageFromGallery() ??
                                      controller.imagePath.value);
                            },
                            child: Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                  color: Colors.grey.shade100,
                                  borderRadius:
                                  BorderRadius.circular(8)),
                              child: const Icon(
                                Icons.image,
                                size: 15,
                                color: primaryColor,
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 12,
                          ),
                          InkWell(
                            onTap: () async {
                              controller.imagePath(
                                  await getImageCamera() ??
                                      controller.imagePath.value);
                            },
                            child: Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                  color: Colors.grey.shade100,
                                  borderRadius:
                                  BorderRadius.circular(8)),
                              child: const Icon(
                                Icons.camera_alt,
                                size: 15,
                                color: primaryColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 6),
                      Obx(() => controller.imagePath.isNotEmpty
                          ? InkWell(
                        onTap: () => controller.imagePath(""),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.delete,
                              color: Colors.red,
                            ),
                            const SizedBox(
                              width: 6,
                            ),
                            const Text(
                              'Delete',
                              style: TextStyle(color: Colors.red),
                            )
                          ],
                        ),
                      )
                          : const SizedBox.shrink())
                    ],
                  )
                ],
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
                height: 20,
              ),
              CustomButton(
                text: "Next",
                btnColor: blackColor,
                onTap: (){},
              ),
            ],
          ),
        ),
      ),
    );

  }
}
