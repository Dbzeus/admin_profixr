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
      ),
      body: Column(
        children: [

        ],
      ),
    );
  }
}
