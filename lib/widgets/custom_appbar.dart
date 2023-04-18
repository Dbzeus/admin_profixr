import 'package:flutter/material.dart';

import '../helpers/custom_colors.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
   CustomAppBar({required this.widget,
this.height = 80,
     Key? key}) : super(key: key);

  Widget widget;
  double height;

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: Size.fromHeight(MediaQuery.of(context).size.height * 0.14),
      child: Container(
          height:  height,
          decoration: const BoxDecoration(
              color: primaryColor,
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(16),
                bottomLeft: Radius.circular(16),
              )),
      child: widget,
      ),

    );

  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size(
    double.maxFinite,
    80
  );

}


