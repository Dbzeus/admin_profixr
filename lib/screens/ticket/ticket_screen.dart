import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:profixer_admin/routes/app_routes.dart';
import 'package:profixer_admin/screens/ticket/ticket_controller.dart';

import '../../helpers/custom_colors.dart';
import '../../widgets/custom_appbar.dart';

class TicketScreen extends GetView<TicketController> {
  final controller = Get.put(TicketController());

  TicketScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        widget: Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Row(
              children: [
                IconButton(
                    onPressed: () {
                      Get.back();
                    },
                    icon: const Icon(
                      Icons.arrow_back,
                      color: whiteColor,
                    )),
                const Text(
                  "Tickets",
                  style: TextStyle(
                      color: whiteColor,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(
          top: 16.0,
          right: 16.0,
          left: 16.0,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 50,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
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
                Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: primaryColor,
                  ),
                  child: Center(
                    child: SvgPicture.asset(
                      'assets/icon/filter.svg',
                      height: 12,
                      width: 12,
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 16,
            ),
            Expanded(
              child: ListView.builder(
                  itemCount: 6,
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemBuilder: (_, index) {
                    return _buildTickets();
                  }),
            ),
          ],
        ),
      ),
    );
  }

  _buildTickets() {
    return GestureDetector(
      onTap: () {
        Get.toNamed(Routes.ticketHistory);
      },
      child: Container(
          width: MediaQuery.of(Get.context!).size.width,
          padding: const EdgeInsets.all(12),
          margin: const EdgeInsets.symmetric(vertical: 6),
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Ticket Number, ",
                        style: TextStyle(
                            color: blackColor,
                            fontSize: 16,
                            fontWeight: FontWeight.w600),
                      ),
                      const Text(
                        "Place ",
                        style: TextStyle(
                            color: blackColor,
                            fontSize: 16,
                            fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Technician Name",
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: TextStyle(
                          fontSize: 10,
                          color: blackColor,
                        ),
                      ),
                      const Text(
                        "Technician Role",
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: TextStyle(
                          fontSize: 10,
                          color: blackColor,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Customer Name",
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: TextStyle(
                          fontSize: 10,
                          color: blackColor,
                        ),
                      ),
                      const Text(
                        "12345678901",
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: TextStyle(
                          fontSize: 10,
                          color: blackColor,
                        ),
                      ),
                    ],
                  ),
                  const Text(
                    "Issue ",
                    style: TextStyle(
                        color: blackColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w600),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Date and Time",
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: TextStyle(
                      fontSize: 10,
                      color: blackColor,
                    ),
                  ),
                  IconButton(
                      onPressed: () {
                        showDropDown();
                        debugPrint("Icon");
                      },
                      icon: const Icon(
                        Icons.more_vert,
                        color: textColor,
                      ))
                ],
              ),
            ],
          )),
    );
  }

  Widget showDropDown() {

        return DropdownButton(
        value: controller.dropDownValue.value,
        style: const TextStyle(color: primaryColor, fontSize: 16),
        underline: const SizedBox(),
        icon: const Icon(
          Icons.keyboard_arrow_down,
          color: primaryColor,
          size: 16,
        ),
        items: controller.items.map((String items) {
          return DropdownMenuItem(
            value: items,
            child: Text(items),
          );
        }).toList(),
        onChanged: (val) {
          controller.dropDownValue(val.toString());
        });
  }
}
