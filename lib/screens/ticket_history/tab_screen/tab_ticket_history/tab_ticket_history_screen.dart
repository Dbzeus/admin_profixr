import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:profixer_admin/screens/ticket_history/tab_screen/tab_ticket_history/tab_ticket_history_controller.dart';

import '../../../../helpers/custom_colors.dart';

class TabTicketHistoryScreen extends GetView<TabTicketHistoryController> {
  final controller = Get.put(TabTicketHistoryController());

  TabTicketHistoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView.builder(
          itemCount: controller.ticketList.length,
          padding: const EdgeInsets.all(6),
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemBuilder: (_, index) {
            return _buildTickets(controller.ticketList[index]);
          }),
    );
  }

  _buildTickets(ticketList) {
    return GestureDetector(
      onTap: () {},
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
                  Text(
                    "Assign to Techinician ${ticketList["techName"].toString()}",
                    style: TextStyle(
                        color: blackColor,
                        fontSize: 16,
                        fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(
                    height: 6,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.call,
                            color: primaryColor,
                            size: 14,
                          ),
                          const SizedBox(
                            width: 4,
                          ),
                          Text(
                            ticketList["cusNo"].toString(),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                        ],
                      ),
                      Container(
                        padding: EdgeInsets.all(4),
                        color: primaryColor,
                        child: const Text(
                          "Assign",
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: TextStyle(
                            fontSize: 12,
                            color: whiteColor,
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
                        ticketList["cusName"].toString(),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: TextStyle(
                          fontSize: 12,
                          color: blackColor,
                        ),
                      ),
                      Text(
                        ticketList["issue"].toString(),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: TextStyle(
                          fontSize: 12,
                          color: blackColor,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Text(
                    ticketList["date"].toString(),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: TextStyle(
                      fontSize: 12,
                      color: blackColor,
                    ),
                  ),
                ],
              ),
            ],
          )),
    );
  }
}
