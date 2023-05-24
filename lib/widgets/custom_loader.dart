import 'package:flutter/material.dart';

class CustomLoader extends StatelessWidget {

  CustomLoader({this.overlayColor=Colors.black26,Key? key}) : super(key: key);

   Color overlayColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      color: overlayColor,
      child: Center(
        child: CircularProgressIndicator()/*Image.asset(
            height: 100,
          width: 100,
          "assets/icon/loader.gif",
          fit: BoxFit.cover,
        )*/
      ),
    );
  }
}
