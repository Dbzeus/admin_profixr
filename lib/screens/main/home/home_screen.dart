import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:profixer_admin/helpers/custom_colors.dart';
import 'package:profixer_admin/helpers/hexcolor.dart';
import 'package:profixer_admin/model/ticket_count_response.dart';

import '../../../routes/app_routes.dart';
import '../main_controller.dart';

class HomeScreen extends StatelessWidget {
  final controller = Get.put(MainController());

  HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize:
            Size.fromHeight(MediaQuery.of(context).size.height * 0.14),
        child: Container(
          height: 100,
          decoration: const BoxDecoration(
              color: whiteColor,
              boxShadow: [
                BoxShadow(
                    color: Colors.black26,
                    blurRadius: 10,
                    offset: Offset(0.0, 0.75))
              ],
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(16),
                bottomLeft: Radius.circular(16),
              )),
          child: Column(
            children: [
              const Spacer(),
              Padding(
                padding: const EdgeInsets.only(left: 16, top: 16, bottom: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      backgroundImage: CachedNetworkImageProvider(
                          controller.userData.imagePath),
                      backgroundColor: Colors.white,
                      radius: 18,
                    ),
                    Expanded(child: Image.asset('assets/icon/logo.png')),
                    IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.notifications_rounded,
                          size: 22,
                          color: Colors.black,
                        ))
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Overview',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  GestureDetector(
                      onTap: (){
                        Get.toNamed(Routes.newTicket);
                      },
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: primaryColor,
                          borderRadius: BorderRadius.circular(8),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.grey.shade100,
                                spreadRadius: 1,
                                blurRadius: 3,
                                offset: const Offset(0, 2))
                          ]),
                      child: Row(
                        children: [
                          const SizedBox(
                            width: 4,
                          ),
                          Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12)),
                            child: const Icon(
                              Icons.add,
                              color: primaryColor,
                              size: 12,
                            ),
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          const Text(
                            'Add Ticket',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                                fontSize: 12),
                          ),
                          const SizedBox(
                            width: 4,
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
            Obx(()=>
               GridView.builder(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 0),
                  itemCount: controller.dashboards.length,
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  physics: const BouncingScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 10,
                      childAspectRatio: 0.8,
                      mainAxisSpacing: 15),
                  itemBuilder: (_, index) {
                    return _buildDashboard(controller.dashboards[index]);
                  }),
            ),
            const SizedBox(
              height: 16,
            ),
          ],
        ),
      ),
    );
  }

  _buildDashboard(TicketCount dashboard) {

    return GestureDetector(
      onTap: () {
        Get.toNamed(Routes.bookedTicket, arguments: {"data": "$dashboard"});
      },
      child: Container(
        margin: const EdgeInsets.only(top: 12),
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
        child: Stack(
          children: [
            Positioned(
                top: -20,
                right: -10,
                child: Container(
                  decoration: BoxDecoration(
                    color: HexColor.fromHex(dashboard.colorCode),
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey.shade100,
                          spreadRadius: 1,
                          blurRadius: 3,
                          offset: const Offset(0, 2))
                    ],
                  ),
                  width: 50,
                  height: 50,
                )),
            Positioned(
                top: 8,
                right: -15,
                child: Container(
                  decoration: BoxDecoration(
                    color: HexColor.fromHex(dashboard.colorCode2),
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey.shade100,
                          spreadRadius: 1,
                          blurRadius: 3,
                          offset: const Offset(0, 2))
                    ],
                  ),
                  width: 40,
                  height: 40,
                )),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CachedNetworkImage(
                    imageUrl: dashboard.statusImage,
                    height: 15,
                    width: 15,
                  ),
                  const Spacer(),
                  Text(
                    "${dashboard.ticketCount}",
                    style: const TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: primaryColor),
                  ),
                  Text(
                    dashboard.statusName,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                        fontSize: 12,
                        color: blackColor,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
