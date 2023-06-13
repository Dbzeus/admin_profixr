import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:profixer_admin/helpers/custom_colors.dart';
import 'package:profixer_admin/model/TicketHistoryResponse.dart';
import 'package:profixer_admin/screens/tickets/ticket_details/ticket_details_controller.dart';
import 'package:profixer_admin/widgets/custom_appbar.dart';

import '../../../helpers/hexcolor.dart';
import '../../../helpers/utils.dart';
import '../../../widgets/custom_loader.dart';

class TicketDetailsScreen extends GetView<TicketDetailsController> {
  TicketDetailsScreen({Key? key}) : super(key: key);

  @override
  final controller = Get.put(TicketDetailsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "Ticket Details",
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Stack(
                  children: [
                    Container(
                      width: MediaQuery.of(Get.context!).size.width,
                      padding: const EdgeInsets.all(12),
                      margin: const EdgeInsets.symmetric(vertical: 15),
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
                        children: [
                          Row(
                            children: [
                              SizedBox(
                                width: 90,
                                height: 40,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Ticket No: ${controller.ticket.ticketNo}",
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                              color: primaryColor,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600),
                                        ),
                                        Container(
                                          height: 20,
                                          width: 20,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(4),
                                            color: const Color.fromRGBO(
                                                0, 169, 206, 1),
                                          ),
                                          child: Center(
                                            child: CachedNetworkImage(
                                              imageUrl: controller.ticket.complientNatureImg,
                                              height: 10,
                                              width: 10,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Icon(
                                          Icons.location_on,
                                          color: primaryColor,
                                          size: 16,
                                        ),
                                        const SizedBox(
                                          width: 4,
                                        ),
                                        Expanded(
                                          child: Text(
                                            "${controller.ticket.customerAddress}",
                                            maxLines: 3,
                                            style: const TextStyle(
                                              color: blackColor,
                                              fontSize: 10,
                                            ),
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
                            height: 14,
                          ),
                          const Divider(),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Name",
                                style: const TextStyle(
                                  color: hintColor,
                                  fontSize: 12,
                                ),
                              ),
                              Text(
                                "${controller.ticket.customerName}",
                                style: const TextStyle(
                                    color: blackColor,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Mobile Number",
                                style: const TextStyle(
                                  color: hintColor,
                                  fontSize: 12,
                                ),
                              ),
                              Row(
                                children: [
                                  const Icon(
                                    Icons.call,
                                    color: blackColor,
                                    size: 16,
                                  ),
                                  const SizedBox(
                                    width: 4,
                                  ),
                                  Text(
                                    "${controller.ticket.mobileNo}",
                                    style: const TextStyle(
                                        color: blackColor,
                                        fontSize: 12,
                                        decoration: TextDecoration.underline,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Service Category",
                                style: const TextStyle(
                                  color: hintColor,
                                  fontSize: 12,
                                ),
                              ),
                              Text(
                                "${controller.ticket.complientNatureName}",
                                style: const TextStyle(
                                    color: blackColor,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Service Name",
                                style: const TextStyle(
                                  color: hintColor,
                                  fontSize: 12,
                                ),
                              ),
                              Text(
                                "${controller.ticket.serviceName}",
                                style: const TextStyle(
                                    color: blackColor,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Service Type",
                                style: const TextStyle(
                                  color: hintColor,
                                  fontSize: 12,
                                ),
                              ),
                              Text(
                                "${controller.ticket.priorityName}",
                                style: const TextStyle(
                                    color: blackColor,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Date & Time",
                                style: const TextStyle(
                                  color: hintColor,
                                  fontSize: 12,
                                ),
                              ),
                              Text(
                                "${controller.ticket.createdDate}",
                                style: const TextStyle(
                                    color: blackColor,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          // const SizedBox(
                          //   height: 10,
                          // ),
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
                          const SizedBox(
                            height: 12,
                          ),
                          controller.ticket.childStatus.isEmpty ? const SizedBox.shrink() : Column(
                            children: [
                              const Divider(),
                              const SizedBox(
                                height: 12,
                              ),
                              SingleChildScrollView(
                                physics: BouncingScrollPhysics(),
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  children: List.generate(
                                    controller.ticket.childStatus.length,
                                        (index) => GestureDetector(
                                      onTap: ()=> controller.ticketUpdate(controller.ticket.childStatus[index]),
                                      child: Row(
                                        children: [
                                          Container(
                                            width: 90,
                                            height: 40,
                                            decoration: BoxDecoration(
                                                color: whiteColor,
                                                borderRadius: BorderRadius.circular(4),
                                                border: Border.all(
                                                  color: HexColor.fromHex(
                                                    controller.ticket.childStatus[index]
                                                        .colorCode,
                                                  ),
                                                )),
                                            child: Center(
                                              child: Row(
                                                mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                                children: [
                                                  CachedNetworkImage(
                                                    imageUrl: controller.ticket
                                                        .childStatus[index].statusImage,
                                                    width: 18,
                                                    height: 18,
                                                  ),
                                                  Text(
                                                    controller.ticket.childStatus[index]
                                                        .childStatusName,
                                                    style: TextStyle(
                                                      fontWeight: FontWeight.w600,
                                                      fontSize: 12,
                                                      color: HexColor.fromHex(
                                                        controller.ticket
                                                            .childStatus[index].colorCode,
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 12,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      left: 20,
                      top: 0,
                      child: Container(
                        height: 80,
                        width: 80,
                        decoration: BoxDecoration(
                          color: primaryColor,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Image.asset(
                          'assets/icon/profixer.png',
                          width: 80,
                          height: 30,
                        ),
                      ),
                    ),
                  ],
                ),
                Obx(() => controller.isHistoryLoading.value
                    ? Center(child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: const CircularProgressIndicator(),
                    ))
                    : controller.histories.isEmpty
                        ? const SizedBox.shrink()
                        : Container(
                            width: MediaQuery.of(Get.context!).size.width,
                            padding: const EdgeInsets.all(12),
                            margin: const EdgeInsets.symmetric(vertical: 15),
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
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Ticket Detail',
                                      style: TextStyle(
                                          color: primaryColor,
                                          fontWeight: FontWeight.w700),
                                    ),
                                    Icon(Icons.download)
                                  ],
                                ),
                                const Divider(),
                                ListView.builder(
                                    itemCount: controller.histories.length,
                                    shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),
                                    itemBuilder: (_, index) {
                                      return _buildTimeLine(controller.histories[index]);
                                    })
                                // _buildTimeLine(
                                //     "Nov 11",
                                //     "09 : 00",
                                //     "New Ticket Booked",
                                //     "Plumbing service is booked by the user (Rajesh)",
                                //     primaryColor),
                                // const SizedBox(height: 12,),
                                // _buildTimeLine(
                                //     "Nov 11",
                                //     "09 : 00",
                                //     "New Ticket Booked",
                                //     "Plumbing service is booked by the user (Rajesh)",
                                //     Colors.green),
                                // const SizedBox(height: 12,),
                                // _buildTimeLine(
                                //     "Nov 11",
                                //     "09 : 00",
                                //     "New Ticket Booked",
                                //     "Plumbing service is booked by the user (Rajesh)",
                                //     blueTextColor),
                                // const SizedBox(height: 16,),
                                // Row(
                                //   mainAxisAlignment: MainAxisAlignment.center,
                                //   children: [
                                //     Text('See all other 4 updated',style: TextStyle(
                                //       color: textColor,
                                //       fontSize: 14
                                //     ),),
                                //     Icon(Icons.arrow_drop_down_rounded,color: textColor,)
                                //   ],
                                // )
                              ],
                            ),
                          )),
              ],
            ),
          ),
          Obx(() => controller.isLoading.value
              ? CustomLoader()
              : const SizedBox.shrink())
        ],
      ),
    );
  }
}

_buildTimeLine(TicketHistory history) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const SizedBox(width: 12,),
      Column(
        children: [
          Text(
            toShowDateFormat(history.createdDate.split(" ")[0],fromFormat: dmy,toFormat: "MMM dd"),
            style: TextStyle(fontWeight: FontWeight.bold,fontSize: 12),
          ),
          const SizedBox(height: 2,),
          Text(history.createdDate.split(" ")[1],style: TextStyle(fontSize: 10),),
        ],
      ),
      const SizedBox(width: 6,),
      Container(
        width: 17,
        height: 17,
        margin: EdgeInsets.symmetric(horizontal: 8),
        decoration: BoxDecoration(
            color: HexColor.fromHex(history.colorCode), shape: BoxShape.circle),
        child: Icon(
          Icons.done_rounded,
          color: Colors.white,
          size: 12,
        ),
      ),
      const SizedBox(width: 6,),
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              history.statusName,
              style: TextStyle(fontWeight: FontWeight.bold, color: HexColor.fromHex(history.colorCode),fontSize: 13),
            ),
            history.remarks.isEmpty ? const SizedBox.shrink() :Text(
              history.remarks,
              style: TextStyle(fontSize: 12),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 4,),
            CircleAvatar(
              backgroundImage: CachedNetworkImageProvider(history.uploadImages),
              radius: 15,
            ),
            const SizedBox(height: 4,),
          ],
        ),
      )
    ],
  );
}
