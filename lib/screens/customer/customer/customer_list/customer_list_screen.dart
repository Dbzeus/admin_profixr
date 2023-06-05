import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:profixer_admin/helpers/custom_colors.dart';
import 'package:profixer_admin/helpers/utils.dart';
import 'package:profixer_admin/model/customer_response.dart';
import 'package:profixer_admin/routes/app_routes.dart';
import 'package:profixer_admin/screens/customer/customer/customer_controller.dart';
import 'package:profixer_admin/widgets/custom_appbar.dart';



class CustomerListScreen extends GetView<CustomerController> {
  @override
  final controller = Get.put(CustomerController());

  CustomerListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "Customer",
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 50,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: Colors.grey.shade100),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey.shade100,
                              spreadRadius: 1,
                              blurRadius: 3,
                              offset: const Offset(0, 2))
                        ]),
                    child: TextFormField(
                      controller: controller.searchController,
                      style: const TextStyle(
                        fontSize: 16,
                        color: textColor,
                      ),
                      decoration: const InputDecoration(
                          hintText: 'Search',
                          border: InputBorder.none,
                          prefixIcon: Icon(
                            Icons.search,
                            color: textColor,
                          ),
                          suffix: Icon(
                            Icons.filter_alt_rounded,
                            color: textColor,
                          )),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                GestureDetector(
                  onTap: () {
                    Get.toNamed(Routes.addCustomer, arguments: {
                      "title": "Add Customer",
                      "buttonTitle": "Add",
                    });
                  },
                  child: Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: primaryColor,
                    ),
                    child: const Center(
                      child: Icon(
                        Icons.add,
                        color: whiteColor,
                      ),
                    ),
                  ),
                )
              ],
            ),
            Obx(
              () => Expanded(
                child: controller.isLoading.value
                    ? const Center(child: CircularProgressIndicator())
                    : controller.customers.isEmpty
                        ? const Center(child: Text('No Customers Found'))
                        : ListView.builder(
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            itemCount: controller.customers.length,
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            physics: const BouncingScrollPhysics(),
                            itemBuilder: (_, index) =>
                                _buildMenu(controller.customers[index])),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _buildMenu(Customer data) {
    return GestureDetector(
      onTap: () {
        Get.toNamed(Routes.addCustomer, arguments: {
          "title": "Edit Customer",
          "buttonTitle": "Save Changes",
          "customer": data
        });
      },
      child: Container(
        padding: const EdgeInsets.all(12),
        margin: const EdgeInsets.symmetric(vertical: 6),
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.grey.shade100),
            boxShadow: [
              BoxShadow(
                  color: Colors.grey.shade100,
                  spreadRadius: 1,
                  blurRadius: 3,
                  offset: const Offset(0, 2))
            ],
            borderRadius: BorderRadius.circular(16)),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  width: 50,
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: primaryColor.withAlpha(30),
                  ),
                  child: Center(
                    child: Text(

                      '${data.firstName.substring(0, 1).toUpperCase()}${data.lastNAme.substring(0, 0).toUpperCase()}',
                      style: const TextStyle(
                        color: primaryColor,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 12,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${data.firstName} ${data.lastNAme}',
                        style: const TextStyle(
                            fontSize: 14,
                            color: blackColor,
                            fontWeight: FontWeight.bold),
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.wifi_calling_3,
                            size: 14,
                            color: primaryColor,
                          ),
                          const SizedBox(
                            width: 6,
                          ),
                          Text(
                            data.mobileNo,
                            style: const TextStyle(
                              fontSize: 12,
                              color: primaryColor,
                            ),
                            maxLines: 1,
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.email,
                                size: 14,
                                color: blackColor,
                              ),
                              const SizedBox(
                                width: 6,
                              ),
                              Text(
                                data.emailID,
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: blackColor,
                                ),
                                maxLines: 1,
                              ),
                            ],
                          ),
                          Text(
                           "DOB: ${toShowDateFormat(data.dob)}",
                            style: const TextStyle(
                              fontSize: 10,
                              color: blackColor,
                            ),
                            maxLines: 1,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const Divider(),
            Column(
              children: [
                Row(
                  children: [
                    Text(
                      'Permanent Address',
                      style: TextStyle(color: blackColor, fontSize: 12),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Expanded(
                      child: Text(
                        '${data.currentAddress}',
                        style: TextStyle(fontSize: 13),
                        maxLines: 2,
                        textAlign: TextAlign.end,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      'Remarks',
                      style: TextStyle(color: blackColor, fontSize: 12),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Expanded(
                      child: Text(
                        '${data.remarks}',
                        style: TextStyle(fontSize: 13),
                        maxLines: 2,
                        textAlign: TextAlign.end,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
