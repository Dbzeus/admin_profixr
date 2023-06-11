import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:profixer_admin/helpers/custom_colors.dart';
import 'package:profixer_admin/helpers/utils.dart';
import 'package:profixer_admin/model/technician_response.dart';
import 'package:profixer_admin/routes/app_routes.dart';
import 'package:profixer_admin/screens/technician/technician_controller.dart';
import 'package:profixer_admin/widgets/custom_appbar.dart';

class TechnicianListScreen extends GetView<TechnicianController> {
  @override
  final controller = Get.put(TechnicianController());

  TechnicianListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "Technician",
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
                    Get.toNamed(Routes.addTechnician, arguments: {
                      "title": "Add Technician",
                      "buttonTitle": "Add",
                      "data": null,
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
                    : controller.technicianList.isEmpty
                        ? const Center(child: Text('No Technicians Found'))
                        : ListView.builder(
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            itemCount: controller.technicianList.length,
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            physics: const BouncingScrollPhysics(),
                            itemBuilder: (_, index) =>
                                _buildList(controller.technicianList[index]),
                          ),
              ),
            )
          ],
        ),
      ),
    );
  }

  _buildList(TechnicainData data) {
    return GestureDetector(
      onTap: () {
        Get.toNamed(Routes.addTechnician, arguments: {
          "title": "Edit Technician",
          "buttonTitle": "Next",
          "data": data
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
                        style: const TextStyle(
                            color: blackColor,
                            fontSize: 14,
                            fontWeight: FontWeight.bold),
                      ),
                      Row(
                        children: [
                          const Icon(
                            Icons.call,
                            color: primaryColor,
                            size: 12,
                          ),
                          const SizedBox(
                            width: 6,
                          ),
                          Text(
                            data.mobileNumber.toString(),
                            style: const TextStyle(
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
                            data.mailID.toString(),
                            style: const TextStyle(
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
                      data.userNAme.toString(),
                      style: const TextStyle(
                        color: blueTextColor,
                        fontSize: 10,
                      ),
                    ),
                    Text(
                      "DOB: ${toShowDateFormat(data.dob).toString()}",
                      style: const TextStyle(
                        color: Colors.green,
                        fontSize: 10,
                      ),
                    )
                  ],
                )
              ],
            ),
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Service Provider Name",
                  style: TextStyle(
                    color: blackColor,
                    fontSize: 12,
                  ),
                ),
                Text(
                  data.serviceProviderName.toString(),
                  style: const TextStyle(
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
                const Text(
                  "Date of Joining",
                  style: TextStyle(
                    color: blackColor,
                    fontSize: 12,
                  ),
                ),
                Text(
                  toShowDateFormat(data.doj).toString(),
                  style: const TextStyle(
                    color: blackColor,
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                const Text(
                  "Services",
                  style: TextStyle(
                    color: blackColor,
                    fontSize: 12,
                  ),
                ),
                const SizedBox(
                  width: 8,
                ),
                Expanded(
                  child: Wrap(
                    direction: Axis.horizontal,
                    spacing: 8,
                    alignment: WrapAlignment.end,
                    children: List.generate(
                      data.serviceName.split(',').length,
                      (index) => Chip(
                        backgroundColor: cardStackColor,
                        padding: const EdgeInsets.symmetric(horizontal: 4),
                        label: Text(
                          data.serviceName.split(",")[index],
                          style: const TextStyle(
                            color: primaryColor,
                            fontWeight: FontWeight.w600,
                            fontSize: 10,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                const Text(
                  "Area",
                  style: TextStyle(
                    color: blackColor,
                    fontSize: 12,
                  ),
                ),
                const SizedBox(
                  width: 8,
                ),
                Expanded(
                  child: Wrap(
                    direction: Axis.horizontal,
                    spacing: 8,
                    alignment: WrapAlignment.end,
                      children: List.generate(
                      data.areaName.split(',').length,
                      (index) => Chip(
                        backgroundColor: cardStackColor,
                        padding: const EdgeInsets.symmetric(horizontal: 4),
                        label: Text(
                          data.areaName.split(",")[index],
                          style: const TextStyle(
                            color: primaryColor,
                            fontWeight: FontWeight.w600,
                            fontSize: 10,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Permanent Address",
                  style: TextStyle(
                    color: blackColor,
                    fontSize: 12,
                  ),
                ),
                const SizedBox(width: 8,),
                Expanded(
                  child: Text(
                    data.permanentAddress.toString(),
                    maxLines: 2,
                    textAlign: TextAlign.end,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: blackColor,
                      fontWeight: FontWeight.w600,
                      fontSize: 12,
                    ),
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
                const Text(
                  "Current Address",
                  style: TextStyle(
                    color: blackColor,
                    fontSize: 12,
                  ),
                ),
                const SizedBox(width: 8,),
                Expanded(
                  child: Text(
                    data.contactAddress.toString(),
                    textAlign: TextAlign.end,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: blackColor,
                      fontWeight: FontWeight.w600,
                      fontSize: 12,
                    ),
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
                      const Icon(
                        Icons.lock,
                        color: blackColor,
                        size: 14,
                      ),
                      const SizedBox(
                        width: 4,
                      ),
                      Text(data.mobileNumber.toString()),
                      const SizedBox(
                        width: 4,
                      ),
                      const Icon(
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
                      controller.insertUpdateTechnician(val, data,true, isShowDialog: false);
                    })
              ],
            )
          ],
        ),
      ),
    );
  }
}
