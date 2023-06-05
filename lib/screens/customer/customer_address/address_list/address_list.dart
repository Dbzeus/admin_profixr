import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:profixer_admin/helpers/custom_colors.dart';
import 'package:profixer_admin/routes/app_routes.dart';
import 'package:profixer_admin/screens/customer/customer_controller.dart';

class AddressList extends StatelessWidget {
  final controller = Get.find<CustomerController>();

  AddressList({Key? key}) : super(key: key);

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
                  "title": "Add Addres",
                  "buttonTitle": "Next",
                  "customer": null
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
        ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: 6,
              padding: const EdgeInsets.symmetric(vertical: 12),
              physics: const BouncingScrollPhysics(),
              itemBuilder: (_, index) => _buildList()),

      ],
    );
  }

  _buildList() {
    return GestureDetector(
      onTap: () {
        Get.toNamed(Routes.addCustomerAddress, arguments: {
          "title": "Edit Address",
          "buttonTitle": "Save Changes",
          //"customer": data
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
                      'Home',
                      style: const TextStyle(
                          fontSize: 14,
                          color: blackColor,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'Address',
                      style: const TextStyle(
                          fontSize: 12,
                          color: blackColor,
                          ),
                    ),
                    Text(
                      'City',
                      style: const TextStyle(
                          fontSize: 12,
                          color: blackColor,
                          ),
                    ),
                    Text(
                      'Landmark',
                      style: const TextStyle(
                          fontSize: 12,
                          color: blackColor,
                          ),
                    ),
                  ],
                ),
              ),
              Switch(
                  value: true,
                  activeColor: Colors.green.shade200,
                  inactiveThumbColor: Colors.red.shade200,
                  onChanged: (val) {})
            ],
          )),
    );
  }
}
