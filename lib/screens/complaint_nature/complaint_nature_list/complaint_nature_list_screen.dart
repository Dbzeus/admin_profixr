import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:profixer_admin/helpers/custom_colors.dart';
import 'package:profixer_admin/routes/app_routes.dart';
import 'package:profixer_admin/widgets/custom_appbar.dart';

import '../complaint_nature_controller.dart';

class ComplaintNatureListScreen extends GetView<ComplaintNatureController> {
  @override
  final controller = Get.put(ComplaintNatureController());

  ComplaintNatureListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: CustomAppBar(
        title: "Complaint Nature",
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
                        onChanged: (text){
                          controller.onSearchChanged(text);
                        },
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
                  GestureDetector(
                    onTap: () {
                      controller.searchController.clear();
                      Get.toNamed(Routes.addComplaintNature,
                          arguments: {"title": "Add Complaint Nature", "buttonTitle": "Add","complaintNature": null,});
                    },
                    child: Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: primaryColor,
                      ),
                      child: const Center(
                        child: Icon(
                          Icons.add,
                          color: whiteColor,
                        ),
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 16,
              ),
             /* const Text(
                "Plumbing",
                style: TextStyle(
                    color: Color.fromRGBO(0, 169, 206, 1),
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 10,
              ),*/
              Obx(()=>Expanded(
                child: controller.isLoading.value
                    ? const Center(child: CircularProgressIndicator())
                    : controller.cNatures.isEmpty
                    ? const Center(child: Text('No Complaint Nature Found'))
                    : ListView.builder(
                    itemCount: controller.cNatures.length,
                    scrollDirection: Axis.vertical,
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    shrinkWrap: true,
                    itemBuilder: (_, index) {
                      return _buildServices(controller.cNatures[index]);
                    }),
              ),),
            ],
          ),
        ),
      ),

    );
  }

  _buildServices(data) {
    return GestureDetector(
      onTap: () {
        controller.searchController.clear();
        Get.focusScope?.unfocus();
        Get.toNamed(Routes.addComplaintNature,arguments: {
          "title": "Edit Complaint Nature",
          "buttonTitle" : "Save Changes",
          "complaintNature" : data,
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
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: CachedNetworkImage(
                  imageUrl: "${data['ComplientNatureImg']}",
                  height: 50,
                  fit: BoxFit.cover,
                  width: 50,
                ),
              ),
              const SizedBox(
                width: 12,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${data['ServiceName']}",
                      style: TextStyle(
                          color: blackColor,
                          fontSize: 14,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Text(
                      "${data['ComplaintNatureName']}",
                      style: TextStyle(
                          color: blackColor,
                          fontSize: 12,
                          ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Text(
                      "${data['Remarks']}",
                      overflow: TextOverflow.ellipsis,
                      maxLines: 4,
                      style: TextStyle(
                        fontSize: 10,
                        color: blackColor,
                      ),
                    ),
                  ],
                ),
              ),

              Switch(
                  value: data["IsActive"],
                  activeColor: Colors.green.shade200,
                  inactiveThumbColor: Colors.red.shade200,
                  onChanged: (val) {
                    controller.updateComplaintNature(val,data);
                  })
            ],
          )),
    );
  }
}
