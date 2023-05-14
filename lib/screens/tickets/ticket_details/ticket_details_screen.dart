import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:profixer_admin/helpers/custom_colors.dart';
import 'package:profixer_admin/widgets/custom_appbar.dart';

class TicketDetailsScreen extends StatelessWidget {
  const TicketDetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "Ticket Details",
      ),
      body: SingleChildScrollView(
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
                                      "Ticket No: 123456789",
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
                                        child: SvgPicture.asset(
                                          'assets/icon/waterdrop.svg',
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
                                    Text(
                                      "1/3, North Street, North Town,\nArabia - 03",
                                      maxLines: 3,
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
                            "Surya",
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
                                Icons.wifi_calling_3,
                                color: blackColor,
                                size: 16,
                              ),
                              const SizedBox(
                                width: 4,
                              ),
                              Text(
                                "9765235990",
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
                            "Plumbing",
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
                            "Tap Fixing",
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
                            "Schedule",
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
                            "25-04-2023 11-12 PM",
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
                      const SizedBox(
                        height: 12,
                      ),
                      const Divider(),
                      const SizedBox(
                        height: 12,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          const SizedBox(
                            width: 10,
                          ),
                          Container(
                            width: 90,
                            height: 40,
                            decoration: BoxDecoration(
                                color: whiteColor,
                                borderRadius: BorderRadius.circular(4),
                                border: Border.all(
                                  color: primaryColor,
                                )),
                            child: Center(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
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
                                        fontSize: 12,
                                        color: primaryColor),
                                  )
                                ],
                              ),
                            ),
                          ),
                          Container(
                            width: 90,
                            height: 40,
                            decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Center(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Icon(
                                    Icons.delete,
                                    color: whiteColor,
                                    size: 18,
                                  ),
                                  Text(
                                    "Reject",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 12,
                                        color: whiteColor),
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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Ticket Detail',
                        style: TextStyle(
                            color: primaryColor, fontWeight: FontWeight.w700),
                      ),
                      Icon(Icons.download)
                    ],
                  ),
                  const Divider(),
                  _buildTimeLine(
                      "Nov 11",
                      "09 : 00",
                      "New Ticket Booked",
                      "Plumbing service is booked by the user (Rajesh)",
                      primaryColor),
                  const SizedBox(height: 12,),
                  _buildTimeLine(
                      "Nov 11",
                      "09 : 00",
                      "New Ticket Booked",
                      "Plumbing service is booked by the user (Rajesh)",
                      Colors.green),
                  const SizedBox(height: 12,),
                  _buildTimeLine(
                      "Nov 11",
                      "09 : 00",
                      "New Ticket Booked",
                      "Plumbing service is booked by the user (Rajesh)",
                      blueTextColor),
                  const SizedBox(height: 16,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('See all other 4 updated',style: TextStyle(
                        color: textColor,
                        fontSize: 14
                      ),),
                      Icon(Icons.arrow_drop_down_rounded,color: textColor,)
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

_buildTimeLine(String lt, String lst, String t, String st, Color color) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Column(
        children: [
          Text(
            lt,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Text(lst),
        ],
      ),
      Container(
        width: 20,
        height: 20,
        margin: EdgeInsets.symmetric(horizontal: 8),
        decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        child: Icon(
          Icons.done_rounded,
          color: Colors.white,
          size: 14,
        ),
      ),
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              t,
              style: TextStyle(fontWeight: FontWeight.bold, color: color),
            ),
            Text(
              st,
              style: TextStyle(fontSize: 12),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            CircleAvatar(
              backgroundImage: CachedNetworkImageProvider('https://lh3.googleusercontent.com/ogw/AOLn63FrRz1Sj7YR6k9tIBht1Hp_Xbr2osMhWRMybXZDRg=s32-c-mo'),
              radius: 13,
            )
          ],
        ),
      )
    ],
  );
}
