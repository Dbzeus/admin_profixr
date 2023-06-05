import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../helpers/custom_colors.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  CustomAppBar(
      {required this.title,
      this.height = 80,
      this.bgColor = primaryColor,
      this.textColor = whiteColor,
      this.iconColor = whiteColor,
      this.showShadow = false,
       this.onTap,
      this.isHaveLeading = true,
      Key? key})
      : super(key: key);

  Color bgColor, textColor, iconColor;
  bool showShadow;
  double height;
  String title;
  Function()? onTap;
  bool isHaveLeading;

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: Size.fromHeight(MediaQuery.of(context).size.height * 0.14),
      child: Container(
        height: height,
        decoration: BoxDecoration(
            color: bgColor,
            boxShadow: showShadow
                ? [
                    const BoxShadow(
                        color: Colors.black26,
                        blurRadius: 6,
                        offset: Offset(0.0, 0.75))
                  ]
                : null,
            borderRadius: const BorderRadius.only(
              bottomRight: Radius.circular(20),
              bottomLeft: Radius.circular(20),
            )),
        child: isHaveLeading
            ? Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                  child: Row(
                    children: [
                      IconButton(
                          onPressed:
                              onTap ??
                              () {
                            Get.back();
                          },
                          icon: Icon(
                            Icons.arrow_back,
                            color: iconColor,
                          )),
                      const SizedBox(
                        width: 12,
                      ),
                      Text(
                        title,
                        style: TextStyle(
                          color: textColor,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
              )
            : Center(
                child: Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Text(
                    title,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: textColor,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
      ),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size(double.maxFinite, 80);
}
