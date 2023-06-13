import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:profixer_admin/helpers/constant_widgets.dart';
import 'package:profixer_admin/helpers/custom_colors.dart';
import 'package:profixer_admin/helpers/utils.dart';
import 'package:profixer_admin/model/customer_response.dart';
import 'package:profixer_admin/screens/customer/customer_address/address_list/address_list.dart';
import 'package:profixer_admin/screens/customer/customer/customer_controller.dart';
import 'package:profixer_admin/widgets/custom_appbar.dart';
import 'package:profixer_admin/widgets/custom_button.dart';
import 'package:profixer_admin/widgets/custom_edittext.dart';
import 'package:profixer_admin/widgets/custom_loader.dart';


class AddCustomerScreen extends StatelessWidget {
  final controller = Get.find<CustomerController>();

  AddCustomerScreen({Key? key}) : super(key: key);

  Customer? customerData = Get.arguments['customer'];

  @override
  Widget build(BuildContext context) {


    if (customerData!=null)  {
     controller.customerId = customerData!.customerID;
      controller.userId = customerData!.userID;

      controller.nameController.text = customerData!.firstName.toString();
      controller.remarkController.text = customerData!.remarks.toString();
      controller.dobController.text =
          toShowDateFormat(customerData!.dob.toString());
      controller.mobileController.text =customerData!.mobileNo.toString();
      controller.emailController.text = customerData!.emailID.toString();
      controller.permanentAddressController.text =
          customerData!.currentAddress.toString();
    } else {
      controller.nameController.clear();
      controller.remarkController.clear();
      controller.dobController.clear();
      controller.mobileController.clear();
      controller.emailController.clear();
      controller.permanentAddressController.clear();
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
              child: Obx(()=>
                 Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 15,
                    ),

                    Obx(
                          () => SizedBox(
                        width: double.infinity,

                        child: CupertinoSlidingSegmentedControl(
                          thumbColor: primaryColor,
                          backgroundColor: cardBgColor,
                          groupValue: controller.isSelectedTag.value,
                          padding: const EdgeInsets.all(6),
                          onValueChanged: (value) {
                            controller.isSelectedTag(value);
                          },
                          children: {
                            0: Text(
                              "Details",
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 12,
                                  color: controller.isSelectedTag.value == 0
                                      ? whiteColor
                                      : primaryColor),
                            ),
                            1: Text(
                              "Address",
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 12,
                                  color: controller.isSelectedTag.value == 1
                                      ? whiteColor
                                      : primaryColor),
                            ),
                          },
                        ),
                      ),
                    ),
                    controller.isSelectedTag.value == 0 ?
                    Expanded(
                      child: Column(
                        children: [

                          const SizedBox(
                            height: 20,
                          ),
                          CustomEditText(
                              hintText: "Customer Name",
                              controller: controller.nameController),
                          const SizedBox(
                            height: 10,
                          ),
                          CustomEditText(
                            hintText: "Mobile Number",
                            controller: controller.mobileController,
                            maxLength: 10,
                            keyboardType: TextInputType.phone,
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
                              controller: controller.emailController),
                          const SizedBox(
                            height: 10,
                          ),
                          CustomEditText(
                              hintText: "Permanent Address",
                              maxLines: 4,
                              controller: controller.permanentAddressController),
                          const SizedBox(
                            height: 10,
                          ),
                          CustomEditText(
                            hintText: "Date Of Birth",
                            showCursor: false,
                            keyboardType: TextInputType.none,
                            controller: controller.dobController,
                            suffixIcon: const Icon(
                              Icons.calendar_month_rounded,
                              color: blackColor,
                              size: 22,
                            ),
                            onTab: () async {
                              controller.dobController.text = await getDate(
                                  initialDate: DateTime(DateTime.now().year -18, DateTime.now().month, DateTime.now().day),
                                  firstDate: DateTime(DateTime.now().year -80, 1, 1),
                                  lastDate: DateTime(DateTime.now().year -18, 12, 31)
                              );
                            },
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          CustomEditText(
                              hintText: "Remarks",
                              maxLines: 4,
                              minLines: 2,
                              controller: controller.remarkController),
                          const SizedBox(
                            height: 10,
                          ),
                          const Spacer(),
                          CustomButton(
                              text: Get.arguments['buttonTitle'],
                              onTap: () {
                                controller.validation(Get.arguments['customer'] != null);
                              }),
                        ],
                      ),
                    ) : AddressList(customerData?.customerID ?? 0)
                  ],
                ),
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
