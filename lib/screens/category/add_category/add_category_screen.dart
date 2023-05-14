
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:profixer_admin/helpers/constant_widgets.dart';
import 'package:profixer_admin/helpers/custom_colors.dart';
import 'package:profixer_admin/screens/category/add_category/add_category_controller.dart';

import 'package:profixer_admin/widgets/custom_appbar.dart';
import 'package:profixer_admin/widgets/custom_button.dart';
import 'package:profixer_admin/widgets/custom_edittext.dart';

class AddCategoryScreen extends GetView<AddCategroyController> {

  @override
  final controller = Get.put(AddCategroyController());
   AddCategoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: controller.title.value

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
                  hintText: "Category Name",
                  controller: controller.categoryNameController),

              const SizedBox(
                height: 10,
              ),
              const Text(
                "Category Logo",
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
              uploadButton(() async {
                controller.imagePath(await getImageFromGallery() ?? controller.imagePath.value);
              }),
              const Spacer(),
              Obx(()=>
                 CustomButton(text: controller.buttonTitle.value, onTap: (){

                }),
              )
            ],
          ),
        ),
      ),
    );
  }
}
