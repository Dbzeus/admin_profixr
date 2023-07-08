import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:profixer_admin/helpers/constant_widgets.dart';
import 'package:profixer_admin/helpers/custom_colors.dart';
import 'package:profixer_admin/screens/complaint_nature/complaint_nature_controller.dart';
import 'package:profixer_admin/widgets/custom_appbar.dart';
import 'package:profixer_admin/widgets/custom_button.dart';
import 'package:profixer_admin/widgets/custom_dropdown.dart';
import 'package:profixer_admin/widgets/custom_edittext.dart';
import 'package:profixer_admin/widgets/custom_loader.dart';

import '../../../helpers/utils.dart';
import '../../../widgets/spinner.dart';

class AddComplaintNatureScreen extends StatelessWidget {
  final controller = Get.find<ComplaintNatureController>();

  AddComplaintNatureScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int natureId = 0;
    debugPrint(Get.arguments['complaintNature'].toString());
    if (Get.arguments['complaintNature'] != null) {
      natureId = Get.arguments['complaintNature']['ComplaintNatureID'];
    controller.selectedService(Get.arguments['complaintNature']['ServiceID'].toString());
      controller.natureNameController.text =
          Get.arguments['complaintNature']['ComplaintNatureName'];
      controller.remarkController.text =
          Get.arguments['complaintNature']['Remarks'];
      controller.selectedIsActive(Get.arguments['complaintNature']['IsActive']);
      controller.imagePath(Get.arguments['complaintNature']['ComplientNatureImg']);

    } else {
      controller.natureNameController.clear();
      controller.remarkController.clear();
      controller.selectedIsActive(true);
      controller.imagePath("");
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
                  Obx(
                        () => Spinner(
                      value: controller.selectedService.value,
                      items: controller.services,
                      onChanged: (val) {
                        if (val == null && val==controller.selectedService.value) return;
                        controller.selectedService(val);
                      },
                      hint: 'Service',
                    ),
                  ),
                  /*Obx(
                    () => CustomDropDown(
                      hintText: "Service",
                      dropDownValue: controller.selectedService.value,
                      items: controller.services,
                      onSelected: (val) {
                        controller.selectedService(val);
                      },
                    ),
                  ),*/
                  const SizedBox(
                    height: 32,
                  ),
                  CustomEditText(
                      hintText: "Complaint Nature",
                      controller: controller.natureNameController),
                  const SizedBox(
                    height: 24,
                  ),
                  CustomEditText(
                      hintText: "Description",
                      maxLines: 4,
                      controller: controller.remarkController),
                  const SizedBox(
                    height: 24,
                  ),
                  const Text(
                    "Complaint Nature Image",
                    style: TextStyle(color: hintColor, fontSize: 12),
                  ),
                  const SizedBox(
                    height: 16,
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
                              height: 70,
                              decoration: BoxDecoration(
                                image: controller.imagePath.isEmpty
                                    ? null
                                    : DecorationImage(
                                    image: controller
                                        .imagePath.value.isURL
                                        ? CachedNetworkImageProvider(
                                        controller.imagePath
                                            .value) as ImageProvider
                                        : FileImage(File(
                                        controller.imagePath.value)),
                                    fit: BoxFit.cover),
                              ),
                              child: controller.imagePath.value.isEmpty
                                  ? const Center(child: Text('Upload images'))
                                  : const SizedBox(width: double.infinity,height: double.infinity,),
                            ),
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
                                  debugPrint(controller.imagePath.value);
                                },
                                child: Container(
                                  padding: EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                      color: Colors.grey.shade100,
                                      borderRadius: BorderRadius.circular(8)),
                                  child: Icon(
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
                                  controller.imagePath(await getImageCamera() ??
                                      controller.imagePath.value);
                                },
                                child: Container(
                                  padding: EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                      color: Colors.grey.shade100,
                                      borderRadius: BorderRadius.circular(8)),
                                  child: Icon(
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
                                Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                ),
                                const SizedBox(
                                  width: 6,
                                ),
                                Text(
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
                    height: 24,
                  ),
                  Obx(
                    () => Row(
                      children: [
                        const Expanded(child: Text('Status')),
                        InkWell(
                          onTap: () {
                            if (controller.selectedIsActive.value == false) {
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
                          onTap: () {
                            if (controller.selectedIsActive.value == true) {
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
                        var data = {
                          "ComplaintNatureID": natureId,
                          "ServiceID": controller.selectedService.value,
                          "ComplaintNatureName":
                              controller.natureNameController.text.trim(),
                          "ComplaintNatureImg": controller.imagePath.value,
                          "Remarks": controller.remarkController.text.trim(),
                          "IsActive": controller.selectedIsActive.value,
                          "CUID":  controller.box.read(Session.userId)
                        };
                        controller.createComplaintNature(
                            data, Get.arguments['complaintNature'] != null);
                      }),
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
  }
}
