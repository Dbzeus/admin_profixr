import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:profixer_admin/helpers/custom_colors.dart';
import 'package:profixer_admin/routes/app_routes.dart';
import 'package:profixer_admin/widgets/custom_appbar.dart';

import '../service_controller.dart';

class ServiceListScreen extends GetView<ServiceController> {
  @override
  final controller = Get.put(ServiceController());

  ServiceListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "Services",
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
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                GestureDetector(
                  onTap: () {
                    Get.toNamed(Routes.addService, arguments: {
                      "title": "Add Service",
                      "buttonTitle": "Add"
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
                    ? Center(child: const CircularProgressIndicator())
                    : controller.services.isEmpty
                        ? Center(child: const Text('No Service Found'))
                        : ListView.builder(
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            itemCount: controller.services.length,
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            physics: const BouncingScrollPhysics(),
                            itemBuilder: (_, index) =>
                                _buildMenu(controller.services[index])),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _buildMenu(data) {
    return GestureDetector(
      onTap: () {
        Get.toNamed(Routes.addService, arguments: {
          "title": "Edit Service",
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
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CachedNetworkImage(
              imageUrl: '${data["ServiceImg"]}',
              height: 50,
              width: 50,
            ),
            const SizedBox(
              width: 12,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    data["ServiceName"],
                    style: const TextStyle(
                        fontSize: 14,
                        color: blackColor,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    data["Remarks"],
                    style: const TextStyle(
                      fontSize: 12,
                      color: blackColor,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          /*  CupertinoSwitch(
                value: data["IsActive"],
                activeColor: Colors.green.shade200,
                thumbColor: Colors.white10,
                trackColor: Colors.red.shade200,
                onChanged: (val) {
                  controller.updateService(val, data);
                }),*/

             Switch(
                value: data["IsActive"],
                activeColor: Colors.green.shade200,
                inactiveThumbColor: Colors.red.shade200,
                onChanged: (val) {
                  controller.updateService(val, data);
                })
          ],
        ),
      ),
    );
  }
}
