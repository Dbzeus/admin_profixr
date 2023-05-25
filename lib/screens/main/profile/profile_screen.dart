import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:profixer_admin/helpers/custom_colors.dart';
import 'package:profixer_admin/routes/app_routes.dart';
import 'package:profixer_admin/screens/main/main_controller.dart';
import 'package:profixer_admin/widgets/custom_appbar.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({Key? key}) : super(key: key);

  final controller = Get.find<MainController>();

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
            const SizedBox(
              height: 24,
            ),
            CircleAvatar(
              backgroundColor: cardBgColor,
              radius: 70,
              child: CircleAvatar(
                backgroundColor: cardStackColor.withAlpha(60),
                radius: 60,
                child: CircleAvatar(
                  backgroundImage: CachedNetworkImageProvider(
                      controller.userData.imagePath ?? ""),
                  radius: 50,
                ),
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            Text(
              '${controller.userData.firstName} ${controller.userData.lastName}',
              style: const TextStyle(
                  color: primaryColor,
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 12,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('${controller.userData.designation}'),
                const VerticalDivider(
                  color: Colors.black,
                  thickness: 4,
                ),
                Row(
                  children: [
                    const Icon(
                      Icons.call,
                      size: 15,
                    ),
                    const SizedBox(
                      width: 4,
                    ),
                    Text(
                      '${controller.userData.mobileNo}',
                      style: const TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold),
                    )
                  ],
                )
              ],
            ),
            const SizedBox(
              height: 12,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 16),
              margin: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: const [
                    BoxShadow(
                        color: Colors.black26,
                        blurRadius: 6,
                        offset: Offset(0.0, 0.75))
                  ]),
              child: Column(
                children: [
                  _buildMenu(Icons.person, 'Change Account Details', () {
                    Get.toNamed(Routes.changeDetails);
                  }),
                  const Divider(),
                  _buildMenu(Icons.lock_person_rounded, 'Change Password', () {
                    Get.toNamed(Routes.changePassword);
                  }),
                  const Divider(),
                  _buildMenu(
                      Icons.info_outline_rounded, 'Privacy Policy', () {}),
                ],
              ),
            ),
            const Spacer(),
            GestureDetector(
              onTap: () {
                controller.box.erase();
                Get.toNamed(Routes.loginSelection);
              },
              child: Container(
                  padding: const EdgeInsets.all(12),
                  margin: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: const [
                        BoxShadow(
                            color: Colors.black26,
                            blurRadius: 6,
                            offset: Offset(0.0, 0.75))
                      ]),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(Icons.logout_outlined, size: 25, color: Colors.red),
                      SizedBox(
                        width: 8,
                      ),
                      Text(
                        'Logout',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.red),
                      ),
                    ],
                  )),
            ),
          ],
        ),
      ),
    );
  }

  _buildMenu(
    IconData icon,
    String title,
    Function()? onTap,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
        child: Row(
          children: [
            Container(
              width: 25,
              height: 25,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: cardStackColor,
              ),
              child: Center(
                  child: Icon(
                icon,
                size: 16,
                color: whiteColor,
              )),
            ),
            const SizedBox(
              width: 8,
            ),
            Expanded(
                child: Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
            )),
            const SizedBox(
              width: 8,
            ),
            const Icon(
              Icons.arrow_forward_outlined,
              size: 20,
              color: Colors.black,
            )
          ],
        ),
      ),
    );
  }
}
