import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:profixer_admin/helpers/custom_colors.dart';
import 'package:profixer_admin/model/customer_response.dart';
import 'package:profixer_admin/routes/app_routes.dart';
import 'package:profixer_admin/screens/tickets/check_customer/check_customer_controller.dart';
import 'package:profixer_admin/widgets/custom_appbar.dart';
import 'package:profixer_admin/widgets/custom_edittext.dart';

class CheckCustomerScreen extends GetView<CheckCustomerController> {
  final controller = Get.put(CheckCustomerController());

  CheckCustomerScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.focusScope!.unfocus();
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: CustomAppBar(
          title: "Check Customer",
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              CustomEditText(
                  hintText: "Customer Name / Mobile Number",
                  controller: controller.customerNameController),
              const SizedBox(
                height: 10,
              ),
              GestureDetector(
                onTap: () {
                  Get.toNamed(Routes.newTicket);
                },
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                  decoration: BoxDecoration(
                      color: cardStackColor,
                      border: Border.all(),
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(16),
                        topRight: Radius.circular(16),
                      )),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(6),
                            decoration: BoxDecoration(
                                color: primaryColor,
                                borderRadius: BorderRadius.circular(8)),
                            child: const Icon(
                              Icons.add,
                              color: whiteColor,
                            ),
                          ),
                          const SizedBox(width: 8,),
                          const Text(
                            "Add as New Customer",
                            style: TextStyle(
                                color: primaryColor,
                                fontSize: 14,
                                fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Obx(
                () => Expanded(
                  child: controller.isLoading.value
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : controller.customers.isEmpty
                          ? const Center(
                              child: Text('No Customers Found'),
                            )
                          : ListView.separated(
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              itemCount: controller.customers.length,
                              padding: const EdgeInsets.symmetric(vertical: 8),
                              physics: const BouncingScrollPhysics(),
                              itemBuilder: (_, index) =>
                                  _buildList(controller.customers[index]), separatorBuilder: (BuildContext context, int index) => const Divider(),),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _buildList(Customer customer) {
    return ListTile(
      leading: Container(
        width: 50,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: primaryColor.withAlpha(30),
        ),
        child: const Center(
          child: Text(
            "R",
            /*city["CityName"]
                .split(" ") as List<String>).map((e) => e.trim().substring(0,1).toUpperCase()).join(""),*/
            style: TextStyle(
              color: primaryColor,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      title: const Text(
        "Rahman",
        style: TextStyle(
            color: blackColor, fontSize: 14, fontWeight: FontWeight.bold),
      ),
      subtitle: Row(
        children: [
          const Icon(
            Icons.wifi_calling_3,
            color: primaryColor,
            size: 12,
          ),
          const Text(
            "+966 1234567890",
            style: TextStyle(
                color: primaryColor, fontSize: 12, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
