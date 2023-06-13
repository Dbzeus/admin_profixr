import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:profixer_admin/helpers/custom_colors.dart';
import 'package:profixer_admin/helpers/utils.dart';
import 'package:profixer_admin/model/profixer_response.dart';
import 'package:profixer_admin/routes/app_routes.dart';
import 'package:profixer_admin/screens/profixer/profixer_controller.dart';
import 'package:profixer_admin/widgets/custom_appbar.dart';

class ProfixerListScreen extends GetView<ProfixerController> {
  @override
  final controller = Get.put(ProfixerController());

  ProfixerListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "Profixer",
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
                    controller.searchController.clear();
                    Get.toNamed(Routes.addProfixer, arguments: {
                      "title": "Add Profixer",
                      "buttonTitle": "Add",
                      "data": null
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
                    : controller.profixers.isEmpty
                        ? const Center(child: Text('No Profixers Found'))
                        : ListView.builder(
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            itemCount: controller.profixers.length,
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            physics: const BouncingScrollPhysics(),
                            itemBuilder: (_, index) =>
                                _buildList(controller.profixers[index]),
                          ),
              ),
            )
          ],
        ),
      ),
    );
  }

  _buildList(ProfixerData data) {
    return GestureDetector(
      onTap: () {
        controller.searchController.clear();
        Get.toNamed(Routes.addProfixer, arguments: {
          "title": "Edit Profixer",
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
                  height: 50,
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
                        fontSize: 22,
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
                            Icons.call,
                            color: primaryColor,
                            size: 12,
                          ),
                          const SizedBox(
                            width: 6,
                          ),
                          Text(
                            data.mobileNo.toString(),
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
                            Icons.person,
                            color: blackColor,
                            size: 12,
                          ),
                          const SizedBox(
                            width: 6,
                          ),
                          Text(
                            data.desigination,
                            style: TextStyle(
                              color: blackColor,
                              fontSize: 12,
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
                      data.lastName.toString(),
                      style: TextStyle(
                        color: blueTextColor,
                        fontSize: 10,
                      ),
                    ),
                    Text(
                      "DOB: ${toShowDateFormat(data.dob)}",
                      style: TextStyle(
                        fontSize: 10,
                      ),
                    ),
                    Text(
                      "DOJ: ${toShowDateFormat(data.doj)}",
                      style: TextStyle(
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
                  "Relieve Status",
                  style: TextStyle(
                    color: blackColor,
                    fontSize: 12,
                  ),
                ),
                Text(
                  data.isRelived ? 'YES' : 'NO',
                  style: TextStyle(
                    color: blackColor,
                    fontWeight: FontWeight.w600,
                    fontSize: 10,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 4,
            ),
            data.isRelived
                ? Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Relieve Date",
                            style: TextStyle(
                              color: blackColor,
                              fontSize: 12,
                            ),
                          ),
                          Text(
                            toShowDateFormat(data.relivedDate).toString(),
                            style: TextStyle(
                              color: blackColor,
                              fontWeight: FontWeight.w600,
                              fontSize: 10,
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
                            "Relieve Reason",
                            style: TextStyle(
                              color: blackColor,
                              fontSize: 12,
                            ),
                          ),
                          Text(
                            data.relivedReason.toString(),
                            style: TextStyle(
                              color: blackColor,
                              fontWeight: FontWeight.w600,
                              fontSize: 10,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                    ],
                  )
                : const SizedBox.shrink(),
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
                const SizedBox(
                  width: 8,
                ),
                Expanded(
                  child: Text(
                    data.permanentAddress.toString(),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.end,
                    style: TextStyle(
                      color: blackColor,
                      fontWeight: FontWeight.w600,
                      fontSize: 10,
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
                Text(
                  "Current Address",
                  style: TextStyle(
                    color: blackColor,
                    fontSize: 12,
                  ),
                ),
                const SizedBox(
                  width: 8,
                ),
                Expanded(
                  child: Text(
                    data.currentAddress.toString(),
                    textAlign: TextAlign.end,
                    style: TextStyle(
                      color: blackColor,
                      fontWeight: FontWeight.w600,
                      fontSize: 10,
                    ),
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
                      Text(
                        data.mobileNo.toString(),
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
                      controller.insertUpdateProfixer(val, data, true,
                          isShowDialog: false);
                    })
              ],
            )
          ],
        ),
      ),
    );
  }
}
