import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:profixer_admin/helpers/custom_colors.dart';
import 'package:profixer_admin/routes/app_routes.dart';

import 'package:profixer_admin/screens/services/service_menu/service_menu_controller.dart';
import 'package:profixer_admin/widgets/custom_appbar.dart';

class ServiceMenuScreen extends GetView<ServiceMenuController> {
  final controller = Get.put(ServiceMenuController());

  ServiceMenuScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "Services",
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
                      decoration: InputDecoration(
                        hintText: 'Search',
                        border: InputBorder.none,
                        prefixIcon: const Icon(
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
            const Text(
              "Plumbing",
              style: TextStyle(
                  color: Color.fromRGBO(0, 169, 206, 1),
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 10,
            ),
            Expanded(
              child: ListView.builder(
                  itemCount: 6,
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemBuilder: (_, index) {
                    return _buildServices();
                  }),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: (){
            Get.toNamed(Routes.addService,arguments: {
              "title": "Add Services",
              "buttonTitle" : "Add"
            });
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

  _buildServices() {
    return GestureDetector(
      onTap: () {

        Get.toNamed(Routes.addService,arguments: {
          "title": "Edit Services",
          "buttonTitle" : "Save Changes"
        });
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
                  ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.asset(
                      "assets/plumber.jpg",
                      height: 85,
                      fit: BoxFit.cover,
                      width: 85,
                    ),
                  ),
                  const SizedBox(
                    width: 12,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "Home Plumbing",
                              style: TextStyle(
                                  color: blackColor,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600),
                            ),
                            Container(
                              height: 20,
                              width: 20,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4),
                                color: const Color.fromRGBO(0, 169, 206, 1),
                              ),
                              child: Center(
                                child: SvgPicture.asset(
                                  'assets/icon/waterdrop.svg',
                                  height: 10,
                                  width: 10,
                                ),
                              ),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        const Text(
                          "A service description includes descriptions of the functional and nonfunctional properties of the service, service interfaces, and the legal and technical constraints or rules for its usage. ",
                          overflow: TextOverflow.ellipsis,
                          maxLines: 4,
                          style: TextStyle(
                            fontSize: 10,
                            color: blackColor,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 10
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text.rich(
                    TextSpan(
                      text: "Amount:",
                      style: TextStyle(
                        fontSize: 14,
                        color: blackColor,
                      ),
                      children: [
                        TextSpan(
                          text: " 250",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: primaryColor,
                          ),
                        ),
                        TextSpan(
                          text: " SAR",
                          style: TextStyle(
                            fontSize: 14,
                            color: blackColor,
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    width: 25,
                    height: 25,
                    decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(4)),
                    child: Center(
                      child: Icon(
                        Icons.delete,
                        size: 16,
                        color: whiteColor,
                      ),
                    ),
                  )
                ],
              ),
            ],
          )),
    );
  }
}
