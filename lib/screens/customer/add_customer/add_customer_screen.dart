import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:profixer_admin/helpers/constant_widgets.dart';
import 'package:profixer_admin/helpers/custom_colors.dart';
import 'package:profixer_admin/widgets/custom_appbar.dart';
import 'package:profixer_admin/widgets/custom_button.dart';
import 'package:profixer_admin/widgets/custom_edittext.dart';
import 'package:profixer_admin/widgets/custom_loader.dart';

import '../../../helpers/utils.dart';
import '../customer_controller.dart';

class AddCustomerScreen extends StatelessWidget {
  final controller = Get.find<CustomerController>();

  AddCustomerScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int customerId = 0;
    int userId = 0;

    if (Get.arguments['customer'] != null) {
      customerId = Get.arguments['customer']['CustomerID'];
      userId = Get.arguments['customer']['UserID'];

      controller.nameController.text = Get.arguments['customer']['FirstName'];
      controller.remarkController.text = Get.arguments['customer']['Remarks'];
      controller.dateController.text = toShowDateFormat(Get.arguments['customer']['DOB']);
      controller.mobileController.text = Get.arguments['customer']['MobileNo'];
      controller.emailController.text = Get.arguments['customer']['EmailID'];
      controller.addressController.text = Get.arguments['customer']['CurrentAddress'];
    } else {
      controller.nameController.clear();
      controller.remarkController.clear();
      controller.dateController.clear();
      controller.mobileController.clear();
      controller.emailController.clear();
      controller.addressController.clear();
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
                      hintText: "Customer Name",
                      controller: controller.nameController),
                  const SizedBox(
                    height: 24,
                  ),
                  CustomEditText(
                      hintText: "Email",
                      controller: controller.emailController),
                  const SizedBox(
                    height: 24,
                  ),
                  CustomEditText(
                      hintText: "Permanent Address",
                      maxLines: 4,
                      controller: controller.addressController),
                  const SizedBox(
                    height: 24,
                  ),
                  CustomEditText(
                    hintText: "Date Of Birth",
                    showCursor: false,
                    keyboardType: TextInputType.none,
                    controller: controller.dateController,
                    suffixIcon: const Icon(
                      Icons.calendar_month_rounded,
                      color: blackColor,
                      size: 22,
                    ),
                    onTab: () async {
                      controller.dateController.text = await getDate();
                    },
                  ),
                  const SizedBox(
                    height: 24,
                  ),

                  CustomEditText(
                      hintText: "Remarks",
                      maxLines: 4,
                      controller: controller.remarkController),
                  const SizedBox(
                    height: 24,
                  ),
                  const Spacer(),
                  CustomButton(
                      text: Get.arguments['buttonTitle'],
                      onTap: () {
                        var data={
                          "CustomerID": customerId,
                          "UserID": userId,
                          "FirstName": controller.nameController.text.trim(),
                          "LastName": "",
                          "MobileNumber": controller.mobileController.text.trim(),
                          "EMailID": controller.emailController.text.trim(),
                          "CurrentAddress": controller.addressController.text.trim(),
                          "DOB": toSendDateFormat(controller.dateController.text),
                          "Remarks": controller.remarkController.text.trim(),
                          "Username": "",
                          "Password": "",
                          "IsActive": true,
                          "CUID": controller.box.read(Session.userId)
                        };

                        controller.createCustomer(
                            data, Get.arguments['customer'] != null);
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
