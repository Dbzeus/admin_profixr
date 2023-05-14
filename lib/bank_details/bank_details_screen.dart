
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:profixer_admin/bank_details/bank_details_controller.dart';
import 'package:profixer_admin/helpers/constant_widgets.dart';
import 'package:profixer_admin/helpers/custom_colors.dart';
import 'package:profixer_admin/widgets/custom_appbar.dart';
import 'package:profixer_admin/widgets/custom_button.dart';
import 'package:profixer_admin/widgets/custom_edittext.dart';

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
              uploadButton(),
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
