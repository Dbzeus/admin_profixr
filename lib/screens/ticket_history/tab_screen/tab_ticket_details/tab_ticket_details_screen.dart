

import 'package:flutter/material.dart';
import 'package:get/get.dart';


import '../../../../helpers/custom_colors.dart';
import 'tab_ticket_details_controller.dart';

class TabTicketDetailsScreen extends GetView<TabTicketDetailsController> {

  final controller = Get.put(TabTicketDetailsController());
  TabTicketDetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(

      padding: const EdgeInsets.all(16.0),

      child: Column(
        children: [
          ListView.builder(
              itemCount: controller.ticketList1.length,
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              itemBuilder: (_,index){
            return buildList(controller.ticketList1[index], controller.ticketList2[index]);
          }
          ),
        ],
      )
      /*Column(
        children: [
          _buildList("TicketNo", "#1234567890"),
          _buildList("SerialNo", "7890"),
          _buildList("status", "success"),
          _buildList("Ticket Type", "pending"),
          _buildList("Issue", "Tap Fixing"),
        ],
      ),*/
    );
  }


  buildList( ticketList1,ticketList2) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(ticketList1.toString(), style: const TextStyle(
          color: blackColor,

          fontSize: 14,
        ),
        ),
        Text(ticketList2.toString(), style: const TextStyle(
            color: blackColor,
            fontSize: 14,
            overflow: TextOverflow.ellipsis,
            fontWeight: FontWeight.w600
        ),
        ),
      ],
    );
  }
}
