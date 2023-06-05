import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:profixer_admin/helpers/custom_colors.dart';
import 'package:profixer_admin/routes/app_routes.dart';
import 'package:profixer_admin/screens/customer/customer_address/customer_address_controller.dart';

import '../../../../model/customer_address_response.dart';

class AddressList extends GetView<CustomerAddressController> {
  int customerId;

  AddressList(this.customerId,{Key? key}) : super(key: key);

  @override
  final controller = Get.put(CustomerAddressController());

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 16,
        ),
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
                Get.toNamed(Routes.addCustomerAddress, arguments: {
                  "title": "Add Address",
                  "buttonTitle": "Save",
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
        Obx(()=> controller.isLoading.value ? Center(child: CircularProgressIndicator(),) :ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: controller.customerAddress.length,
              padding: const EdgeInsets.symmetric(vertical: 12),
              physics: const BouncingScrollPhysics(),
              itemBuilder: (_, index) => _buildList(controller.customerAddress[index])),),

      ],
    );
  }

  _buildList(CustomerAddress data) {
    return GestureDetector(
      onTap: () {
        Get.toNamed(Routes.addCustomerAddress, arguments: {
          "title": "Edit Address",
          "buttonTitle": "Save Changes",
          "address": data
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
          child: Row(

            children: [
              Container(
                width: 70,
                height: 70,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: primaryColor.withAlpha(30),
                ),
                child: const Center(
                    child: Icon(
                  Icons.location_on,
                  size: 32,
                  color: primaryColor,
                )),
              ),
            const SizedBox(
              width:  16,
            ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${data.firstName}',
                      style: const TextStyle(
                        fontSize: 12,
                        color: blackColor,
                      ),
                    ),
                    Text(
                      '${data.addressTitle}',
                      style: const TextStyle(
                          fontSize: 14,
                          color: blackColor,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      '${data.streetName}',
                      style: const TextStyle(
                          fontSize: 12,
                          color: blackColor,
                          ),
                    ),

                    Text(
                      '${data.landMark}',
                      style: const TextStyle(
                          fontSize: 12,
                          color: blackColor,
                          ),
                    ),
                  ],
                ),
              ),
              Switch(
                  value: data.isActive,
                  activeColor: Colors.green.shade200,
                  inactiveThumbColor: Colors.red.shade200,
                  onChanged: (val) {
                    data.isActive=val;
                    controller.insertCustomerAddress(data, !data.isActive,showDialog: false);
                  })
            ],
          )),
    );
  }
}
