import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:profixer_admin/helpers/custom_colors.dart';
import 'package:profixer_admin/routes/app_routes.dart';
import 'package:profixer_admin/widgets/custom_appbar.dart';

import '../holiday_controller.dart';

class HolidayListScreen extends GetView<HolidayController> {
  @override
  final controller = Get.put(HolidayController());

  HolidayListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "Holiday",
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
                      onChanged: (text){
                        controller.onSearchChanged(text);
                      },
                      decoration: const InputDecoration(
                          hintText: 'Search',
                          border: InputBorder.none,
                          prefixIcon: Icon(
                            Icons.search,
                            color: textColor,
                          ),
                          /*suffix: Icon(
                            Icons.filter_alt_rounded,
                            color: textColor,
                          )*/),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                GestureDetector(
                  onTap: () {
                    Get.toNamed(Routes.addHoliday, arguments: {
                      "title": "Add Holiday",
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
                    : controller.holidays.isEmpty
                        ? Center(child: const Text('No Holiday Found'))
                        : ListView.builder(
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            itemCount: controller.holidays.length,
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            physics: const BouncingScrollPhysics(),
                            itemBuilder: (_, index) =>
                                _buildMenu(controller.holidays[index])),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _buildMenu(data) {
    return Container(
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
                    data["HolidayDate"].toString().split("T")[0].substring(9),
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
                      data["Reason"],
                      style: const TextStyle(
                          fontSize: 14,
                          color: blackColor,
                          fontWeight: FontWeight.bold),
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.calendar_month_outlined,
                          size: 14,
                          color: primaryColor,
                        ),
                        const SizedBox(width: 4,),
                        Text(
                          data["HolidayDate"].toString().split("T")[0],
                          style: const TextStyle(
                            fontSize: 12,
                            color: primaryColor,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
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
                    'From: ${data["TimeSlot"].toString().split("-")[0].trim()}',
                    style: const TextStyle(
                      fontSize: 12,
                      color: blackColor,
                    ),
                  ),
                  Text(
                    'To: ${data["TimeSlot"].toString().split("-")[1].trim()}',
                    style: const TextStyle(
                      fontSize: 12,
                      color: blackColor,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Text(
                    'Remark',
                    style: TextStyle(
                        color: primaryColor,
                        fontWeight: FontWeight.w700,
                        fontSize: 13),
                  ),
                  Text(
                    '${data["Remarks"]}',
                    style: TextStyle(fontSize: 13),
                  ),
                ],
              ),
              InkWell(
                onTap: () async {
                  controller.deleteHoliday(data);
                },
                child: Container(
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(8)),
                  child: Icon(
                    Icons.delete,
                    size: 15,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
