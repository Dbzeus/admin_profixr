import 'package:flutter/material.dart';

import '../helpers/custom_colors.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
   CustomAppBar({required this.widget,
this.height = 80,
     this.bgColor=primaryColor,
     this.showShadow=false,
     Key? key}) : super(key: key);

  Widget widget;
  Color bgColor;
  bool showShadow;
  double height;

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: Size.fromHeight(MediaQuery.of(context).size.height * 0.14),
      child: Container(
          height:  height,
          decoration: BoxDecoration(
              color: bgColor,
              boxShadow: showShadow ? [
                  BoxShadow(
                      color: Colors.black26,
                      blurRadius: 10,
                      offset: Offset(0.0, 0.75)
                  )
              ] : null,
              borderRadius: const BorderRadius.only(
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


