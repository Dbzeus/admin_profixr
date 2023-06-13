import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:profixer_admin/helpers/utils.dart';
import 'package:profixer_admin/model/admin_response.dart';

import '../../../../helpers/custom_colors.dart';
import '../../../../routes/app_routes.dart';
import '../service_provider_admin_controller.dart';

class ServiceProviderAdminList extends GetView<ServiceProviderAdminController> {
  @override
  final controller = Get.put(ServiceProviderAdminController());

  ServiceProviderAdminList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
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
                  ),
                ),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            GestureDetector(
              onTap: () {
                controller.searchController.clear();
                Get.toNamed(Routes.addAdminServiceProvider, arguments: {
                  "title": "Add Admin",
                  "buttonTitle": "Next",
                  "service": null
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
          () => controller.isLoading.value
              ? const Center(child: CircularProgressIndicator())
              : controller.serviceProviderAdmin.isEmpty
                  ? Center(
                      child: Column(
                      children: [
                        const SizedBox(
                          height: 100,
                        ),
                        Center(child: Text('No Admin Found')),
                      ],
                    ))
                  : ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: controller.serviceProviderAdmin.length,
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (_, index) =>
                          _buildList(controller.serviceProviderAdmin[index]),
                    ),
        )
      ],
    );
  }

  _buildList(AdminData data) {
    return GestureDetector(
      onTap: () {
        controller.searchController.clear();
        Get.toNamed(Routes.addAdminServiceProvider, arguments: {
          "title": "Edit Admin",
          "buttonTitle": "Save Changes",
          "service": data
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
                      data.firstName.substring(0, 2).toUpperCase().toString(),
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
                        data.firstName.toString(),
                        style: TextStyle(
                            color: blackColor,
                            fontSize: 14,
                            fontWeight: FontWeight.bold),
                      ),
                      Row(
                        children: [
                          const Icon(
                            Icons.wifi_calling_3,
                            color: primaryColor,
                            size: 12,
                          ),
                          const SizedBox(
                            width: 6,
                          ),
                          Text(
                            data.mobileNumber.toString(),
                            style: TextStyle(
                              color: primaryColor,
                              fontSize: 10,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          const Icon(
                            Icons.mail,
                            color: blackColor,
                            size: 12,
                          ),
                          const SizedBox(
                            width: 6,
                          ),
                          Text(
                            data.mailID.toString(),
                            style: TextStyle(
                              color: blackColor,
                              fontSize: 10,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      data.serviceProviderName.toString(),
                      style: TextStyle(
                        color: blueTextColor,
                        fontSize: 10,
                      ),
                    ),
                    Text(
                      toShowDateFormat(data.dob).toString(),
                      style: TextStyle(
                        color: Colors.green,
                        fontSize: 10,
                      ),
                    ),
                  ],
                )
              ],
            ),
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Date of joining",
                  style: TextStyle(
                    color: blackColor,
                    fontSize: 12,
                  ),
                ),
                Text(
                  toShowDateFormat(data.doj).toString(),
                  style: TextStyle(
                    color: blackColor,
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 4,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Permanent Address",
                  style: TextStyle(
                    color: blackColor,
                    fontSize: 12,
                  ),
                ),
                Text(
                  data.permanentAddress.toString(),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: blackColor,
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 4,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Current Address",
                  style: TextStyle(
                    color: blackColor,
                    fontSize: 12,
                  ),
                ),
                Text(
                  data.contactAddress.toString(),
                  style: TextStyle(
                    color: blackColor,
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 8,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Row(
                    children: [
                      Icon(
                        Icons.lock,
                        color: blackColor,
                        size: 14,
                      ),
                      const SizedBox(
                        width: 4,
                      ),
                      Text(
                        data.mobileNumber.toString(),
                        style: TextStyle(
                          color: blackColor,
                          fontSize: 12,
                        ),
                      ),
                      const SizedBox(
                        width: 4,
                      ),
                      Icon(
                        Icons.visibility,
                        color: primaryColor,
                        size: 18,
                      ),
                    ],
                  ),
                ),
                Switch(
                    value: data.isActive,
                    activeColor: Colors.green.shade200,
                    inactiveThumbColor: Colors.red.shade200,
                    onChanged: (val) {
                      controller.enableAndDisableServiceProviderAdmin(val, data);
                    })
              ],
            )
          ],
        ),
      ),
    );
  }
}
