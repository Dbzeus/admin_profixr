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
        widget: Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 8,vertical: 6),
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
                const SizedBox(width: 12,),
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
                  itemCount: controller.ticketList.length,
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemBuilder: (_, index) {
                    return _buildTickets(controller.ticketList[index]);
                  }),
            ),
          ],
        ),
      ),
    );
  }

  _buildTickets(ticketList) {
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
                       Text(
                        ticketList["no"].toString(),
                        style: TextStyle(
                            color: blackColor,
                            fontSize: 16,
                            fontWeight: FontWeight.w600),
                      ),
                       Text(
                        ticketList["place"].toString(),
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
                       Text(
                        ticketList["techName"].toString(),
                         overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: TextStyle(
                          fontSize: 12,
                          color: blackColor,
                        ),
                      ),
                       Text(
                        ticketList["role"].toString(),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: TextStyle(
                          fontSize: 12,
                          color: blackColor,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                       Text(
                         "Customer: "+ ticketList["cusName"].toString(),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: TextStyle(
                          fontSize: 12,
                          color: blackColor,
                        ),
                      ),
                      Text(
                        ticketList["cusNo"].toString(),
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
                   Row(

                     children: [
                       Container(
                         color: primaryColor,
                         padding: const EdgeInsets.all(4),
                         child: Text("External",style: TextStyle(
                           color: whiteColor
                         ),),
                       ),
                       const SizedBox(
                         width: 8,
                       ),
                       Container(
                         color: cardStackColor,
                         padding: const EdgeInsets.all(4),
                         child: Text("Medium",style: TextStyle(
                           color: whiteColor
                         ),),
                       ),
                       const SizedBox(
                         width: 8,
                       ),
                       Container(
                         color: cardBgColor,
                         padding: const EdgeInsets.all(4),
                         child: Text("None",style: TextStyle(
                           color: blackColor,
                         ),),
                       ),
                       const SizedBox(
                         width: 8,
                       ),
                       ticketList["ticket"] == "open" ?
                         Container(
                           color: Colors.green.shade400,
                           padding: const EdgeInsets.all(4),
                           child: Text(ticketList["ticket"].toString(),style: TextStyle(
                             color: blackColor,
                           ),),
                         ) : ticketList["ticket"] == "Assign" ? Container(
                         color: Colors.yellow,
                         padding: const EdgeInsets.all(4),
                         child: Text(ticketList["ticket"].toString(),style: TextStyle(
                           color: blackColor,
                         ),),
                       ) : Container(
                         color: Colors.red,
                         padding: const EdgeInsets.all(4),
                         child: Text(ticketList["ticket"].toString(),style: TextStyle(
                           color: blackColor,
                         ),),
                       ),


                     ],
                   ),
                   const SizedBox(
                     height: 6,
                   ),
                   Text(
                     "Issue: "+  ticketList["issue"].toString(),
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
                   Text(
                    ticketList["date"].toString(),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: TextStyle(
                      fontSize: 10,
                      color: blackColor,
                    ),
                  ),
                  PopupMenuButton(

                      child: Icon(
                        Icons.more_vert,
                        color: textColor,
                      ),

                      itemBuilder: (_){
                        return List.generate(
                            controller.items.length,
                                (index) {
                              return PopupMenuItem(
                                child: showDropDown(controller.items[index]),
                              );
                            });
                      }),
                ],
              ),
            ],
          )),
    );
  }

  Widget showDropDown(String item) {
    return Row(
      children: [
        Icon(Icons.downloading,
          color: primaryColor,),
        const SizedBox(width: 8),
        Text(item),
      ],
    );
  }
}
