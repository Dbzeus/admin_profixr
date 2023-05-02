import 'package:flutter/material.dart';
import 'package:get/get.dart';



import '../../helpers/custom_colors.dart';
import 'tab_screen/tab_ticket_details/tab_ticket_details_screen.dart';
import 'tab_screen/tab_ticket_history/tab_ticket_history_screen.dart';

class TicketHistoryScreen extends StatelessWidget {
  const TicketHistoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: const Icon(
                Icons.arrow_back,
                color: whiteColor,
              )),
          title: Text("Ticket History",style: TextStyle(
              color: whiteColor,
              fontSize: 18,
              fontWeight: FontWeight.bold),
          ),
          bottom: TabBar(
            labelColor: whiteColor,
            indicatorColor: whiteColor,
            tabs: [
              Tab(
                text: "Ticket Detail",

              ),
              Tab(
                text: "Ticket History",
              ),
            ],
          ),
        ),
body: TabBarView(
  children: [
    TabTicketDetailsScreen(),
    TabTicketHistoryScreen(),

  ],
),

      ),

    );
  }
}
