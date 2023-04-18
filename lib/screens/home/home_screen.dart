import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/svg.dart';
import 'package:profixer_admin/helpers/custom_colors.dart';
import 'package:profixer_admin/screens/home/home_controller.dart';
import 'package:profixer_admin/widgets/custom_appbar.dart';

class HomeScreen extends GetView<HomeController> {
  final controller = Get.put(HomeController());

  HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
          height: 100,
          widget: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 12),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end ,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end ,

                  children: [
                    const CircleAvatar(
                      //backgroundImage: AssetImage("assets/icon/logo.png"),
                      backgroundColor: Colors.white,
                      radius: 23,
                    ),
                    const SizedBox(
                      width: 16,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        const Text(
                          "Mohamed",
                          style: TextStyle(fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: whiteColor),
                        ),
                        const Text(
                          "Admin",
                          style:
                          const TextStyle(fontSize: 12, color: whiteColor),
                        ),
                      ],
                    ),
                  ],
                ),
                IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.menu,
                      size: 28,
                      color: whiteColor,
                    ))
              ],
            ),

          ),

      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            GridView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 12,vertical: 16),
                itemCount: 4,
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                physics: const BouncingScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    childAspectRatio: 1.2,
                    mainAxisSpacing: 10),
                itemBuilder: (_,index){
                  return _buildDashboard();
            })
          ],
        ),
      ),
    );
  }
  _buildDashboard(){
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
          border: Border.all(color: borderColor,),
          borderRadius: BorderRadius.circular(16)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          SvgPicture.asset(
            'assets/icon/user.svg',
            height: 30,
            width: 30,
          ),
          const Spacer(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: const [
              Text(
                "Users",
                style: TextStyle(fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: blackColor),
              ),
               Text(
                "5 Members",
                style:
                 TextStyle(fontSize: 12, color: blackColor),
              ),
            ],
          )
        ],
      ),
    );
  }
}
