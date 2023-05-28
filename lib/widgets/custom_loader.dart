import 'package:flutter/material.dart';

import '../helpers/custom_colors.dart';

class CustomLoader extends StatelessWidget {
  CustomLoader({this.overlayColor, Key? key}) : super(key: key);

  Color? overlayColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      color: overlayColor ?? primaryColor.withOpacity(0.1),
      child: Center(
        child: Image.asset(
          "assets/loader.gif",
          width: 150,
        ),
      ),
    );
  }
}
