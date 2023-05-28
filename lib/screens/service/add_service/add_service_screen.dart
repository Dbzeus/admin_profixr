import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:profixer_admin/helpers/constant_widgets.dart';
import 'package:profixer_admin/helpers/custom_colors.dart';
import 'package:profixer_admin/widgets/custom_appbar.dart';
import 'package:profixer_admin/widgets/custom_button.dart';
import 'package:profixer_admin/widgets/custom_edittext.dart';
import 'package:profixer_admin/widgets/custom_loader.dart';

import '../../../helpers/utils.dart';
import '../service_controller.dart';

class AddServiceScreen extends StatelessWidget {
  final controller = Get.find<ServiceController>();

  AddServiceScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int serviceId = 0;

    if (Get.arguments['service'] != null) {
      serviceId = Get.arguments['service']['ServiceID'];
      controller.serviceNameController.text =
          Get.arguments['service']['ServiceName'];
      controller.remarkController.text = Get.arguments['service']['Remarks'];
      controller.imagePath(Get.arguments['service']['ServiceImage']);
      controller.selectedIsActive(Get.arguments['service']['IsActive']);

    }else{
      controller.serviceNameController.clear();
      controller.remarkController.clear();
      controller.imagePath("");
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
                      hintText: "Service Name",
                      controller: controller.serviceNameController),
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
                    "Service Image",
                    style: TextStyle(color: hintColor, fontSize: 12),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  /*Obx(() => controller.imagePath.value.isNotEmpty
                      ? Container(
                          width: MediaQuery.of(context).size.width,
                          height: 150,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                                image: controller.imagePath.value.isURL
                                    ? CachedNetworkImage(
                                            imageUrl: controller.imagePath.value)
                                        as ImageProvider
                                    : FileImage(File(controller.imagePath.value)),
                                fit: BoxFit.cover),
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
                          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                          child: Align(
                            alignment: Alignment.topRight,
                            child: GestureDetector(
                                onTap: () {
                                  controller.imagePath("");
                                },
                                child: Icon(
                                  Icons.close,
                                  color: Colors.white,
                                )),
                          ),
                        )
                      : const SizedBox()),*/
                  const SizedBox(
                    height: 16,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Obx(() => Container(
                              height: 50,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: controller.imagePath.value.isNotEmpty
                                      ? primaryColor
                                      : Colors.black26,
                                ),
                                image: DecorationImage(
                                    image: controller.imagePath.value.isURL
                                        ? CachedNetworkImage(
                                        imageUrl: controller.imagePath.value)
                                    as ImageProvider
                                        : FileImage(File(controller.imagePath.value)),
                                    fit: BoxFit.cover),
                              ),
                              child: const Center(child: Text('Upload images')),
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
                                  controller.imagePath(await getImageFromGallery() ??
                                      controller.imagePath.value);
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
                                  controller.imagePath(
                                      await getImageCamera() ?? controller.imagePath.value);
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
                          Obx(()=> controller.imagePath.isNotEmpty ? InkWell(
                            onTap: ()=> controller.imagePath(""),
                            child: Row(
                              children: [
                                Icon(Icons.delete,color: Colors.red,),
                                const SizedBox(width: 6,),
                                Text('Delete',style: TextStyle(
                                  color: Colors.red
                                ),)
                              ],
                            ),
                          ) : const SizedBox.shrink() )
                        ],
                      )

                    ],
                  ),
                  /*uploadButton(() async {
                  controller.imagePath(await getImageFromGallery() ?? controller.imagePath.value);
                }),*/
                  const SizedBox(
                    height: 32,
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
                        var area = {
                          "ServiceID": serviceId,
                          "ServiceName": controller.serviceNameController.text,
                          "ServiceImg": controller.imagePath.value,
                          "Remarks": controller.remarkController.text,
                          "IsActive": controller.selectedIsActive.value,
                          "CUID": controller.box.read(Session.userId)
                        };
                        controller.createService(
                            area, Get.arguments['service'] != null);
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
