import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:profixer_admin/helpers/custom_colors.dart';
import 'package:profixer_admin/widgets/custom_loader.dart';

import '../../../../helpers/constant_widgets.dart';
import '../../../../widgets/custom_button.dart';
import '../../../../widgets/custom_dropdown.dart';
import '../../../../widgets/custom_edittext.dart';
import 'tikcet_updation_controller.dart';

enum UpdationType { ASSIGN, REMARK, REMARK_REASON }

getUpdationType(String type) {
  switch (type) {
    case "assign":
      return UpdationType.ASSIGN;
    case "remark":
      return UpdationType.REMARK;
    case "reason":
      return UpdationType.REMARK_REASON;
  }
}

ticketUpdationDialog(
  context,
  UpdationType type, {
  isDismissable = true,
}) {
  final controller = Get.put(TicketUpdationController());

  if(type==UpdationType.ASSIGN){
    controller.getServiceProviders();
  }

  showDialog(
      context: context,
      barrierDismissible: isDismissable,
      builder: (context) {
        return WillPopScope(
          onWillPop: () async => isDismissable,
          child: Stack(
            children: [
              Dialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                backgroundColor: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Visibility(
                        visible: type == UpdationType.ASSIGN,
                        child: Column(
                          children: [
                            Obx(
                              () => CustomDropDown(
                                hintText: "Service Provider",
                                dropDownValue:
                                    controller.selectedProvider.value,
                                items: controller.providers,
                                onSelected: (val) {
                                  controller.selectedProvider(val);
                                  controller.getTechnicians();
                                },
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Obx(
                              () => CustomDropDown(
                                hintText: "Technician",
                                dropDownValue:
                                    controller.selectedTechnicians.value,
                                items: controller.technicians,
                                onSelected: (val) {
                                  controller.selectedTechnicians(val);
                                },
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                          ],
                        ),
                      ),
                      Visibility(
                          visible: type == UpdationType.REMARK_REASON,
                          child: Column(
                            children: [
                              CustomEditText(
                                  hintText: "Reason",
                                  controller: controller.reasonController),
                              const SizedBox(
                                height: 8,
                              ),
                            ],
                          )),
                      CustomEditText(
                          hintText: "Remarks",
                          controller: controller.remarksController),
                      const SizedBox(
                        height: 16,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Obx(() => DottedBorder(
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
                                          : const SizedBox.shrink()),
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
                        height: 32,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CustomButton(
                              width: MediaQuery.of(context).size.width * 0.3,
                              height: 38,
                              btnColor: Colors.white,
                              textColor: Colors.black,
                              border: Border.all(
                                color: primaryColor,
                              ),
                              borderRadius: 4,
                              text: 'Cancel',
                              onTap: () {
                                Get.back();
                              }),
                          const SizedBox(
                            width: 12,
                          ),
                          CustomButton(
                              width: MediaQuery.of(context).size.width * 0.3,
                              height: 38,
                              borderRadius: 4,
                              text: 'OK',
                              onTap: () {
                                var result = {
                                  'providerId':
                                      controller.selectedProvider.value,
                                  'techId':
                                      controller.selectedTechnicians.value,
                                  'remark':
                                      controller.remarksController.text.trim(),
                                  'reason':
                                      controller.reasonController.text.trim(),
                                  'image': controller.imagePath.value
                                };
                                Get.back(result: result);
                              }),
                        ],
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                    ],
                  ),
                ),
              ),
              Obx(() => controller.isLoading.value
                  ? CustomLoader()
                  : const SizedBox.shrink())
            ],
          ),
        );
      });
}
