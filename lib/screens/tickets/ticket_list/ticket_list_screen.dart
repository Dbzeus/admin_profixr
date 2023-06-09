import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:profixer_admin/helpers/custom_colors.dart';
import 'package:profixer_admin/helpers/hexcolor.dart';
import 'package:profixer_admin/routes/app_routes.dart';
import 'package:profixer_admin/widgets/custom_appbar.dart';

import '../../../model/TicketListResponse.dart';
import 'ticket_list_controller.dart';

class TicketListScreen extends GetView<TicketListController> {
  @override
  final controller = Get.put(TicketListController());

  TicketListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: CustomAppBar(
        title: controller.data.statusName,
      ),
      body: GestureDetector(
        onTap: () => Get.focusScope?.unfocus(),
        child: Padding(
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
                child: Obx(
                  () => controller.isLoading.value
                      ? Center(
                          child: CircularProgressIndicator(),
                        )
                      : controller.ticketList.isEmpty
                          ? Center(
                              child: Text('No Tickets Found'),
                            )
                          : ListView.builder(
                              padding: EdgeInsets.only(bottom: 70),
                              itemCount: controller.ticketList.length,
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              itemBuilder: (_, index) {
                                return _buildTickets(
                                    controller.ticketList[index]);
                              }),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  _buildTickets(Ticket item) {
    return GestureDetector(
      onTap: () {
        controller.searchController.clear();
        Get.toNamed(Routes.ticketDetails,arguments: item);
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
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 45,
                  width: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color: const Color.fromRGBO(0, 169, 206, 1),
                  ),
                  child: Center(
                    child: CachedNetworkImage(
                      imageUrl: item.complientNatureImg,
                    )
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Ticket No: ${item.ticketNo}",
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            color: blackColor,
                            fontSize: 14,
                            fontWeight: FontWeight.w600),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            item.serviceName,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                            style: const TextStyle(
                              color: blueTextColor,
                              fontSize: 10,
                            ),
                          ),
                          Text(
                            item.createdDate.split(" ")[0],
                            style: const TextStyle(
                              color: blackColor,
                              fontSize: 10,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      Row(
                        children: [
                          Text(
                            item.customerName,
                            style: const TextStyle(
                              color: blackColor,
                              fontSize: 10,
                            ),
                          ),
                          const SizedBox(
                            width: 3,
                          ),
                          Container(
                            height: 3,
                            width: 3,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: primaryColor,
                            ),
                          ),
                          const SizedBox(
                            width: 3,
                          ),
                          const Icon(
                            Icons.call,
                            color: primaryColor,
                            size: 12,
                          ),
                          const SizedBox(
                            width: 4,
                          ),
                          Text(
                            item.mobileNo,
                            style: const TextStyle(
                                color: primaryColor,
                                fontSize: 10,
                                decoration: TextDecoration.underline),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      Text(
                        item.customerAddress,
                        style: const TextStyle(
                          color: blackColor,
                          fontSize: 10,
                        ),
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              item.complientNatureName,
                              style: const TextStyle(
                                color: blackColor,
                                fontSize: 10,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Text(
                            item.createdDate.split(" ")[1],
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
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            // RichText(
            //     text: const TextSpan(
            //         style: TextStyle(
            //           fontSize: 15,
            //           color: blackColor,
            //         ),
            //         children: [
            //       TextSpan(text: "Amount: "),
            //       TextSpan(
            //         text: "250",
            //         style: TextStyle(
            //             fontSize: 22,
            //             color: primaryColor,
            //             fontWeight: FontWeight.bold),
            //       ),
            //       TextSpan(text: " SAR"),
            //     ])),
            item.childStatus.isEmpty ? const SizedBox.shrink() :
                Column(
                  children: [
                    const Divider(),
                    SingleChildScrollView(
                      physics: BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: List.generate(item.childStatus.length, (index) =>  Row(
                          children: [
                            GestureDetector(
                              onTap: ()=> controller.ticketUpdate(item,item.childStatus[index]),
                              child: Container(
                                width: 90,
                                height: 30,
                                decoration: BoxDecoration(
                                    color: whiteColor,
                                    borderRadius: BorderRadius.circular(4),
                                    border: Border.all(
                                      color: HexColor.fromHex(item.childStatus[index].colorCode,),
                                    )),
                                child: Center(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      CachedNetworkImage(imageUrl: item.childStatus[index].statusImage,width: 18,height: 18,),
                                      Text(
                                        item.childStatus[index].childStatusName,
                                        style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 12,
                                          color: HexColor.fromHex(item.childStatus[index].colorCode,),),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 12,),
                          ],
                        ),),
                      ),
                    ),
                  ],
                ),
          ],
        ),
      ),
    );
  }

}
