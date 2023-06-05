import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:profixer_admin/helpers/custom_colors.dart';
import 'package:profixer_admin/helpers/utils.dart';
import 'package:profixer_admin/model/serviceprovider_response.dart';
import 'package:profixer_admin/routes/app_routes.dart';
import 'package:profixer_admin/screens/service_provider/service_provider_controller.dart';
import 'package:profixer_admin/widgets/custom_appbar.dart';

class ServiceProviderListScreen extends GetView<ServiceProviderController> {
  final controller = Get.put(ServiceProviderController());

  ServiceProviderListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "Service Provider",
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
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
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                GestureDetector(
                  onTap: () {
                    Get.toNamed(Routes.addServiceProvider, arguments: {
                      "title": "Add Service Provider",
                      "buttonTitle": "Next",
                      "slider": false
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
              () =>Expanded(child:  controller.isLoading.value
                  ? const Center(child: CircularProgressIndicator())
                  : controller.serviceProviders.isEmpty
                      ? const Center(child: Text('No Service Provider Found'))
                      : ListView.builder(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: controller.serviceProviders.length,
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: (_, index) =>
                            _buildList(controller.serviceProviders[index]),
                      ),
            ))
          ],
        ),
      ),
    );
  }

  _buildList(ServiceProviderData data) {
    return GestureDetector(
      onTap: () {
         Get.toNamed(Routes.addServiceProvider,
            arguments: {
              "title": "Edit Service Provider",
              "buttonTitle" : "Next",
              "service":data,
              "slider": true
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
                  child:  Center(
                    child: Text(
                      data.contactPerson.substring(0,2).toUpperCase().toString(),
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
                        data.contactPerson.toString(),
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
                            data.contactNumber.toString(),
                            style: TextStyle(
                              color: primaryColor,
                              fontSize: 12,
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
                            data.contactMailID.toString(),
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
                      data.contactPerson.toString(),
                      style: TextStyle(
                        color: blueTextColor,
                        fontSize: 10,
                      ),
                    ),
                    Text(
                      toShowDateFormat(data.contractStartDate).toString(),
                      style: TextStyle(
                        color: Colors.green,
                        fontSize: 10,
                      ),
                    ),
                    Text(
                      toShowDateFormat(data.contractEndDate).toString(),
                      style: TextStyle(
                        color: Colors.red,
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
                  "Service Provider Name",
                  style: TextStyle(
                    color: blackColor,
                    fontSize: 12,
                  ),
                ),
                Text(
                  data.serviceProviderName.toString(),
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
                  "Services",
                  style: TextStyle(
                    color: blackColor,
                    fontSize: 12,
                  ),
                ),
                Chip(
                  backgroundColor: cardStackColor,
                  padding: EdgeInsets.symmetric(horizontal: 4),
                  label: Text(
                    data.serviceName.toString(),
                    style: TextStyle(
                      color: primaryColor,
                      fontWeight: FontWeight.w600,
                      fontSize: 10,
                    ),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Area",
                  style: TextStyle(
                    color: blackColor,
                    fontSize: 12,
                  ),
                ),
                Chip(
                  backgroundColor: cardStackColor,
                  padding: EdgeInsets.symmetric(horizontal: 4),
                  label: Text(
                    data.areaName.toString(),
                    style: TextStyle(
                      color: primaryColor,
                      fontWeight: FontWeight.w600,
                      fontSize: 10,
                    ),
                  ),
                ),
              ],
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
                  data.contactAddress.toString(),
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
                  "Tax Details",
                  style: TextStyle(
                    color: blackColor,
                    fontSize: 12,
                  ),
                ),
                Text(
                  data.taxDetails.toString(),
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
                  "Bank Details",
                  style: TextStyle(
                    color: blackColor,
                    fontSize: 12,
                  ),
                ),
                Text(
                  data.bankDetails.toString(),
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
                      Text(data.contactNumber.toString()),
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
                    onChanged: (val) {})
              ],
            )
          ],
        ),
      ),
    );
  }
}
