import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:profixer_admin/helpers/custom_colors.dart';
import 'package:profixer_admin/widgets/custom_appbar.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

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
              backgroundColor: primaryColor.withAlpha(30),
              radius: 70,
              child: CircleAvatar(
                backgroundColor: primaryColor.withAlpha(60),
                radius: 60,
                child: CircleAvatar(
                  backgroundImage: CachedNetworkImageProvider(
                    'https://lh3.googleusercontent.com/ogw/AOLn63FrRz1Sj7YR6k9tIBht1Hp_Xbr2osMhWRMybXZDRg=s32-c-mo'
                  ),
                  radius: 50,
                ),
              ),
            ),
            const SizedBox(height: 12,),
            Text('Mohamad Rahman',style: TextStyle(
              color: primaryColor,
              fontSize: 18,
              fontWeight: FontWeight.bold
            ),),
            const SizedBox(height: 12,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Admin'),
                const VerticalDivider(color: Colors.black,thickness: 4,),
                Row(
                  children: [
                    Icon(Icons.call,size: 15,),
                    const SizedBox(width: 4,),
                    Text('+966 1234567891',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),)
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
                  _buildMenu('assets/icon/menu/category.png','Change Account Detail',(){}),
                  const Divider(),
                  _buildMenu('assets/icon/menu/category.png','Change Password',(){}),
                  const Divider(),
                  _buildMenu('assets/icon/menu/category.png','Privacy Policy',(){}),
                ],
              ),
            ),
            const Spacer(),
            Container(
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
                  Image.asset('assets/icon/menu/category.png',width: 20,height: 20,),
                  const SizedBox(width: 8,),
                  Text('Logout',style: TextStyle(
                      fontWeight: FontWeight.bold,
                    color: Colors.red
                  ),),
                ],
              )
            ),
          ],
        ),
      ),
    );
  }

  _buildMenu(String imagePath,String title,Function onTab){
    return GestureDetector(
      onTap: ()=>onTab,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Image.asset(imagePath,width: 20,height: 20,),
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
