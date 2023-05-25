import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:profixer_admin/helpers/custom_colors.dart';
import 'package:profixer_admin/routes/app_routes.dart';
import 'package:profixer_admin/screens/main/main_controller.dart';
import 'package:profixer_admin/widgets/custom_appbar.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({Key? key}) : super(key: key);

  final controller=Get.find<MainController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "Profile",
        bgColor: whiteColor,
        textColor: blackColor,
        iconColor: blackColor,
        showShadow: true,
        isHaveLeading: false,
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 24,),
            CircleAvatar(
              backgroundColor: cardBgColor,
              radius: 70,
              child: CircleAvatar(
                backgroundColor: cardStackColor.withAlpha(60),
                radius: 60,
                child: const CircleAvatar(
                  backgroundImage: AssetImage("assets/icon/menu/profixer.png",),/*CachedNetworkImageProvider(
                    'https://lh3.googleusercontent.com/ogw/AOLn63FrRz1Sj7YR6k9tIBht1Hp_Xbr2osMhWRMybXZDRg=s32-c-mo'
                  ),*/
                  radius: 50,
                ),
              ),
            ),
            const SizedBox(height: 12,),
            Text('${controller.userData.firstName} ${controller.userData.lastName}',style: TextStyle(
              color: primaryColor,
              fontSize: 18,
              fontWeight: FontWeight.bold
            ),),
            const SizedBox(height: 12,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('${controller.userData.designation}'),
                const VerticalDivider(color: Colors.black,thickness: 4,),
                Row(
                  children: [
                    Icon(Icons.call,size: 15,),
                    const SizedBox(width: 4,),
                    Text('${controller.userData.mobileNo}',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),)
                  ],
                )
              ],
            ),
            const SizedBox(height: 12,),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 6,vertical: 16),
              margin: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  const BoxShadow(
                      color: Colors.black26,
                      blurRadius: 6,
                      offset: Offset(0.0, 0.75)
                  )
                ]
              ),
              child: Column(
                children: [
                  _buildMenu(Icons.person,'Change Account Details',(){
                    Get.toNamed(Routes.changeDetails);
                  }),
                  const Divider(),
                  _buildMenu(Icons.lock_person_rounded,'Change Password',(){
                    Get.toNamed(Routes.changePassword);
                  }),
                  const Divider(),
                  _buildMenu(Icons.info_outline_rounded,'Privacy Policy',(){}),
                ],
              ),
            ),
            const Spacer(),
            GestureDetector(
              onTap: (){
                Get.toNamed(Routes.loginSelection);
              },
              child: Container(
                padding: EdgeInsets.all(12),
                margin: EdgeInsets.all(16),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      const BoxShadow(
                          color: Colors.black26,
                          blurRadius: 6,
                          offset: Offset(0.0, 0.75)
                      )
                    ]
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.logout_outlined ,
                      size: 25,
                        color: Colors.red
                    ),
                    const SizedBox(width: 8,),
                    Text('Logout',style: TextStyle(
                        fontWeight: FontWeight.bold,
                      color: Colors.red
                    ),),
                  ],
                )
              ),
            ),
          ],
        ),
      ),
    );
  }

  _buildMenu(IconData icon,String title,  Function()? onTap,){
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: cardStackColor,
              ),
              child: Center(
                child: Icon(
                 icon ,
                  size: 20,
                  color: whiteColor,
                )
              ),
            ),
            const SizedBox(width: 8,),
            Expanded(child: Text(title,style: TextStyle(
              fontWeight: FontWeight.bold
            ),)),
            const SizedBox(width: 8,),
            Icon(Icons.arrow_forward_outlined,size: 20,color: Colors.black,)
          ],
        ),
      ),
    );
  }
}
