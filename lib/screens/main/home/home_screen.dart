import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:profixer_admin/helpers/custom_colors.dart';
import 'package:profixer_admin/widgets/custom_appbar.dart';

import 'home_controller.dart';

class HomeScreen extends GetView<HomeController> {
  @override
  final controller = Get.put(HomeController());

  HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
          height: 100,
          widget: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end ,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const CircleAvatar(
                  backgroundImage: CachedNetworkImageProvider('https://lh3.googleusercontent.com/ogw/AOLn63FrRz1Sj7YR6k9tIBht1Hp_Xbr2osMhWRMybXZDRg=s32-c-mo'),
                  backgroundColor: Colors.white,
                  radius: 20,
                ),
                SvgPicture.asset('assets/icon/full_logo.svg'),
                /*Row(
                  crossAxisAlignment: CrossAxisAlignment.end ,
                  children: [
                    const CircleAvatar(
                      backgroundImage: CachedNetworkImageProvider('https://lh3.googleusercontent.com/ogw/AOLn63FrRz1Sj7YR6k9tIBht1Hp_Xbr2osMhWRMybXZDRg=s32-c-mo'),
                      backgroundColor: Colors.white,
                      radius: 20,
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
                          const TextStyle(fontSize: 11, color: whiteColor),
                        ),
                      ],
                    ),
                  ],
                ),*/
                IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.notifications_rounded,
                      size: 20,
                      color: Colors.white,
                    ))
              ],
            ),

          ),

      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('OverView',style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,

              ),),
            ),
            GridView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 12,vertical: 16),
                itemCount: 4,
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                physics: const BouncingScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 10,
                    childAspectRatio: 1.1,
                    mainAxisSpacing: 15),
                itemBuilder: (_,index){
                  return _buildDashboard();
            }),
            const SizedBox(height: 16,),
          ],
        ),
      ),
    );
  }
  _buildDashboard(){
    return Stack(
      fit: StackFit.expand,
      children: [
        RotationTransition(
          turns:   const AlwaysStoppedAnimation(13/ 360),
          child: Container(
            margin: const EdgeInsets.only(left:  20,
                right: 20,bottom: 50),
            decoration:  BoxDecoration(
                color: cardStackColor,
                borderRadius: BorderRadius.circular(16)
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(left:  8,
          right: 8,top: 8),
          decoration:  BoxDecoration(
            color: primaryColor,
              borderRadius: BorderRadius.circular(16)
          ),
        ),
      Container(
        margin: const EdgeInsets.only(top: 14),
       padding: const EdgeInsets.all(10),
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
         mainAxisAlignment: MainAxisAlignment.center,
         children: [
           SvgPicture.asset(
             'assets/icon/user.svg',
             height: 12,
             width: 12,
           ),
           const SizedBox(height: 6,),
           Text(
             "25",
             style: TextStyle(fontSize: 16,
                 fontWeight: FontWeight.bold,
                 color: blackColor),
           ),
           const SizedBox(height: 6,),
           Text(
             "Booked",
             style:
             TextStyle(fontSize: 12, color: blackColor),
           ),

         ],
       ),
        ),],
    );
  }
}
