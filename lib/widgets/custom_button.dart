import 'package:flutter/material.dart';
import 'package:profixer_admin/helpers/custom_colors.dart';

class CustomButton extends StatelessWidget {
  double? height, width;
  double borderRadius;
  Color textColor;
  Color btnColor;
  String text;
  Function() onTap;
  EdgeInsets? margin;
  Border? border;

  CustomButton({
    Key? key,
    this.width,
    this.height=50,
    this.margin,
    this.borderRadius=24,
    this.border,
    this.btnColor = primaryColor,
    this.textColor=whiteColor,
    required this.text,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: height,
        width: width ?? double.infinity,
        margin: margin,
        decoration: BoxDecoration(
          color: btnColor,
          borderRadius: BorderRadius.circular(borderRadius),
          border: border
        ),
        child: Center(
            child: Text(
              text,
              style: TextStyle(color: textColor),
            )),
      ),
    );
  }
}
