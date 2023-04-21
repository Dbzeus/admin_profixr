import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:profixer_admin/screens/ticket/ticket_controller.dart';

class TicketScreen extends GetView<TicketController> {
  final controller = Get.put(TicketController());
   TicketScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
