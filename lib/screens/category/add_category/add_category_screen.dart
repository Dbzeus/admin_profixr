
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
    return GestureDetector(
      onTap: (){
        Get.focusScope!.unfocus();
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
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
                uploadButton(),
                const Spacer(),
                Obx(()=>
                   CustomButton(text: controller.buttonTitle.value, onTap: (){

                  }),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
