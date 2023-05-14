import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:profixer_admin/helpers/custom_colors.dart';
import 'package:profixer_admin/widgets/custom_appbar.dart';

import '../../../routes/app_routes.dart';
import 'home_controller.dart';

class HomeScreen extends GetView<HomeController> {
  @override
  final controller = Get.put(HomeController());

  HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  PreferredSize(
        preferredSize: Size.fromHeight(MediaQuery.of(context).size.height * 0.14),
        child: Container(
          height:  100,
          decoration: BoxDecoration(
              color: whiteColor,
              boxShadow:  [
                BoxShadow(
                    color: Colors.black26,
                    blurRadius: 10,
                    offset: Offset(0.0, 0.75)
                )
              ] ,
              borderRadius: const BorderRadius.only(
                bottomRight: Radius.circular(16),
                bottomLeft: Radius.circular(16),
              )),
          child:  Column(
            children: [
              const Spacer(),
              Padding(
                padding: const EdgeInsets.only(left: 16,top: 16,bottom: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const CircleAvatar(
                      backgroundImage: CachedNetworkImageProvider('https://lh3.googleusercontent.com/ogw/AOLn63FrRz1Sj7YR6k9tIBht1Hp_Xbr2osMhWRMybXZDRg=s32-c-mo'),
                      backgroundColor: Colors.white,
                      radius: 18,
                    ),
                    Expanded(child: Image.asset('assets/icon/logo.png')),
                    IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.notifications_rounded,
                          size: 22,
                          color: Colors.black,
                        ))
                  ],
                ),

              ),
            ],
          ),
        ),

      ),

      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12,vertical: 16),
              child: Text('OverView',style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),),
            ),
            GridView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 12,vertical: 0),
                itemCount: controller.dashboard.length,
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                physics: const BouncingScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 10,
                    childAspectRatio: 0.8,
                    mainAxisSpacing: 15),
                itemBuilder: (_,index){
                  return _buildDashboard(controller.dashboard[index]);
            }),
            const SizedBox(height: 16,),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
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

  _buildDashboard(Map<String, String> dashboard){
    return GestureDetector(
      onTap: (){
        Get.toNamed(Routes.bookedTicket,arguments: {
          "title":"${dashboard['title']}"
        });
      },
      child: Container(
        margin: const EdgeInsets.only(top: 12),
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
        child: Stack(
          children: [
            Positioned(
                top: -20,
                right: -10,
                child: Container(
                  decoration: BoxDecoration(
                      color: Color.fromRGBO(245, 190, 134, 1),
                      shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey.shade100,
                          spreadRadius: 1,
                          blurRadius: 3,
                          offset: const Offset(0, 2))
                    ],
                  ),
                  width: 50,
                  height: 50,
                )),
            Positioned(
                top: 8,
                right: -15,
                child: Container(
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(255, 227, 200, 1),
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey.shade100,
                          spreadRadius: 1,
                          blurRadius: 3,
                          offset: const Offset(0, 2))
                    ],
                  ),
                  width: 40,
                  height: 40,
                )),
            Positioned(
                bottom: 0,
                right: 0,
                child: Container(
                  decoration: BoxDecoration(
                      color: blackColor,
                      borderRadius: BorderRadius.only(bottomRight: Radius.circular(16),topLeft: Radius.circular(8))
                  ),
                  width: 30,
                  height: 30,
                  child: Center(
                    child: SvgPicture.asset('assets/icon/arrow.svg'),
                  ),
                )),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12,horizontal: 12),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SvgPicture.asset(
                    dashboard['icon']!,
                    height: 15,
                    width: 15,
                  ),
                  const Spacer(),
                  Text(
                    "${dashboard['count']}",
                    style: TextStyle(fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: primaryColor),
                  ),
                  Text(
                    "${dashboard['title']}",
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style:
                    TextStyle(fontSize: 12, color: blackColor, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8,),
                ],
              ),
            ),

          ],
        ),
      ),
    );
  }


  /*_buildDashboard(){
    return GestureDetector(
      onTap: (){
        Get.toNamed(Routes.ticket);
      },
      child: Stack(
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
      ),
    );
  }*/
}
