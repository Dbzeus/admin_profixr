import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:profixer_admin/helpers/custom_colors.dart';
import 'package:profixer_admin/routes/app_routes.dart';
import 'package:profixer_admin/screens/profixer/profixer_controller.dart';

import 'package:profixer_admin/widgets/custom_appbar.dart';

class ProfixerListScreen extends GetView<ProfixerController> {

  final controller= Get.put(ProfixerController());
   ProfixerListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "Profixer",
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
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
                GestureDetector(
                  onTap: () {
                    Get.toNamed(Routes.addProfixer,
                        arguments: {"title": "Add Profixer", "buttonTitle": "Add"});
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
            Expanded(
              child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: 2,
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (_, index) => _buildList(),),
            )

          ],
        ),
      ),
    );
  }

  _buildList() {
    return GestureDetector(
      onTap: () {
        Get.toNamed(Routes.addProfixer,
            arguments: {"title": "Edit Profixer", "buttonTitle": "Next"});
       /* Get.toNamed(Routes.addService,
            arguments: {
              "title": "Edit Service",
              "buttonTitle" : "Save Changes",
              "service":data
            });*/
      },
      child: Container(
        padding: const EdgeInsets.all(12),
        margin:  const EdgeInsets.symmetric(vertical: 6),
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
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  width: 50,
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: primaryColor.withAlpha(30),
                  ),
                  child: const Center(
                    child: Text(
                      "Ra",
                      style: const TextStyle(
                        color: primaryColor,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 12,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Rahman", style: TextStyle(
                          color: blackColor,
                          fontSize: 14,
                          fontWeight: FontWeight.bold
                      ),),
                      Row(
                        children: [
                          const Icon(
                            Icons.wifi_calling_3,
                            color: primaryColor,
                            size: 12,
                          ),
                          const SizedBox(
                            width: 6,
                          ),
                          Text("+966 1234567890", style: TextStyle(
                              color: primaryColor,
                              fontSize: 12,

                          ),),
                        ],
                      ),
                      Row(
                        children: [
                          const Icon(
                            Icons.mail,
                            color: blackColor,
                            size: 12,
                          ),
                          const SizedBox(
                            width: 6,
                          ),
                          Text("demo@gmail.com", style: TextStyle(
                              color: blackColor,
                              fontSize: 12,

                          ),),
                        ],
                      ),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Rahman125", style: TextStyle(
                        color: blueTextColor,
                        fontSize: 12,

                    ),),
                    Text("Rahman125", style: TextStyle(
                      color: Colors.green,
                      fontSize: 12,

                    ),),Text("Rahman125", style: TextStyle(
                      color: Colors.red,
                      fontSize: 12,

                    ),),
                  ],
                )
              ],
            ),
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Service Provider Name", style: TextStyle(
                  color: blackColor,
                  fontSize: 12,

                ),),
                Text("Surya (Ramon Electronics)", style: TextStyle(
                  color: blackColor,
                  fontWeight: FontWeight.w600,
                  fontSize: 12,

                ),),
              ],
            ),
            const SizedBox(
              height: 4,
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Date of Joining", style: TextStyle(
                  color: blackColor,
                  fontSize: 12,

                ),),
                Text("25-05-2023", style: TextStyle(
                  color: blackColor,
                  fontWeight: FontWeight.w600,
                  fontSize: 12,

                ),),
              ],
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Services", style: TextStyle(
                  color: blackColor,
                  fontSize: 12,

                ),),
                Chip(
                  backgroundColor: cardStackColor,

                  padding: EdgeInsets.symmetric(horizontal: 4),
                  label:Text("Plumbing", style: TextStyle(
                  color: primaryColor,
                  fontWeight: FontWeight.w600,
                  fontSize: 10,

                ),), ),

              ],
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Area", style: TextStyle(
                  color: blackColor,
                  fontSize: 12,

                ),),
                Chip(
                  backgroundColor: cardStackColor,

                  padding: EdgeInsets.symmetric(horizontal: 4),
                  label:Text("Muscat", style: TextStyle(
                    color: primaryColor,
                    fontWeight: FontWeight.w600,
                    fontSize: 10,

                  ),), ),
              ],
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Permanent Address", style: TextStyle(
                  color: blackColor,
                  fontSize: 12,

                ),),
                Text("Surya (Ramon Electronics)",
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                  color: blackColor,
                  fontWeight: FontWeight.w600,
                  fontSize: 12,

                ),),
              ],
            ),
            const SizedBox(
              height: 4,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Current Address", style: TextStyle(
                  color: blackColor,
                  fontSize: 12,

                ),),
                Text("Surya (Ramon Electronics)", style: TextStyle(
                  color: blackColor,
                  fontWeight: FontWeight.w600,
                  fontSize: 12,

                ),),
              ],
            ),

            const SizedBox(
              height: 8,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Row(
                    children: [
                      Icon(
                        Icons.lock,
                        color: blackColor,
                        size: 14,
                      ),
                      const SizedBox(
                        width: 4,
                      ),
                      Text("12345"),
                      const SizedBox(
                        width: 4,
                      ),
                      Icon(
                        Icons.visibility,
                        color: primaryColor,
                        size: 18,
                      ),
                    ],
                  ),
                ),
                Switch(
                    value: true,
                    activeColor: Colors.green.shade200,
                    inactiveThumbColor: Colors.red.shade200,
                    onChanged: (val) {

                    })
              ],
            )
          ],
        ),
      ),
    );
  }
}
