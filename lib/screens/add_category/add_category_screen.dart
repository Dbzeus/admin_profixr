
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:profixer_admin/helpers/constant_widgets.dart';
import 'package:profixer_admin/helpers/custom_colors.dart';
import 'package:profixer_admin/screens/add_category/add_category_controller.dart';
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
                  "Add Category",
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
              CustomButton(text: "Add", onTap: (){

              })
            ],
          ),
        ),
      ),
    );
  }
}
