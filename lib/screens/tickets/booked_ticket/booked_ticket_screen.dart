import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:profixer_admin/helpers/custom_colors.dart';
import 'package:profixer_admin/routes/app_routes.dart';

import 'package:profixer_admin/widgets/custom_appbar.dart';

import 'booked_ticket_controller.dart';



class BookedTicketScreen extends GetView<BookedTicketController> {
  final controller = Get.put(BookedTicketController());

  BookedTicketScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: CustomAppBar(
        title: controller.title,
      ),
      body: GestureDetector(
        onTap: ()=>Get.focusScope?.unfocus(),
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
                child: ListView.builder(
                  padding: EdgeInsets.only(bottom: 70),
                    itemCount: controller.ticketList.length,
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemBuilder: (_, index) {
                      return _buildTickets2(controller.ticketList[index]);
                    }),
              ),

            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: (){
            Get.focusScope?.unfocus();
            Get.toNamed(Routes.newTicket);
          },
          elevation: 4,
          backgroundColor: primaryColor,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
                Radius.circular(8)
            ),
          ),
          child: const Icon(
            Icons.add,
            color: whiteColor,
          )
      ),
    );
  }


  _buildTickets2(ticketList) {
    return GestureDetector(
      onTap: (){
          Get.toNamed(Routes.ticketDetails);
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
                    child: SvgPicture.asset(
                      'assets/icon/waterdrop.svg',
                      height: 25,
                      width: 25,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Text(
                            "Ticket No: 123456789",
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                                color: blackColor,
                                fontSize: 14,
                                fontWeight: FontWeight.w600),
                          ),
                          Text(
                            "Home Plumbing",
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                            style: const TextStyle(
                              color: blueTextColor,
                              fontSize: 10,
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
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                ticketList["cusName"].toString(),
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
                                Icons.wifi_calling_3,
                                color: primaryColor,
                                size: 12,
                              ),
                              const SizedBox(
                                width: 3,
                              ),
                              Text(
                                ticketList["cusNo"].toString(),
                                style: const TextStyle(
                                    color: primaryColor,
                                    fontSize: 10,
                                    decoration: TextDecoration.underline),
                              ),
                            ],
                          ),
                          Text(
                            ticketList["date"].toString(),
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
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              "1/3, North Street, North Town, Arabia - 03",
                              style: const TextStyle(
                                color: blackColor,
                                fontSize: 10,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Text(
                            "10 - 11 pm",
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
            RichText(
                text: const TextSpan(
                    style: TextStyle(
                      fontSize: 15,
                      color: blackColor,
                    ),
                    children: [
                  TextSpan(text: "Amount: "),
                  TextSpan(
                    text: "250",
                    style: TextStyle(
                        fontSize: 22,
                        color: primaryColor,
                        fontWeight: FontWeight.bold),
                  ),
                  TextSpan(text: " SAR"),
                ])),
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const SizedBox(
                  width: 10,
                ),
                Container(
                  width: 90,
                  height: 30,
                  decoration: BoxDecoration(
                      color: whiteColor,
                      borderRadius: BorderRadius.circular(4),
                      border: Border.all(
                        color: primaryColor,

                      )),
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: const [
                         Icon(
                          Icons.check,
                          color: primaryColor,
                          size: 18,
                        ),
                        Text(
                          "Accept",
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 12, color: primaryColor),
                        )
                      ],
                    ),
                  ),
                ),
                Container(
                  width: 90,
                  height: 30,
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Icon(
                          Icons.delete,
                          color: whiteColor,
                          size: 18,
                        ),
                        Text(
                          "Reject",
                          style: TextStyle(
                              fontWeight: FontWeight.w600,fontSize: 12, color: whiteColor),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

 /* Widget showDropDown(String item) {
    return Row(
      children: [
        Icon(
          Icons.downloading,
          color: primaryColor,
        ),
        const SizedBox(width: 8),
        Text(item),
      ],
    );
  }*/
}
