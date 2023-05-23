import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:profixer_admin/helpers/custom_colors.dart';
import 'package:profixer_admin/widgets/custom_button.dart';


customDialog(context,Function onTab){
  showDialog(context: context, builder: (context){
    return Dialog(

      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      backgroundColor: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 16,),
            Image.asset('assets/icon/profixer.png',height: 100,),
            const SizedBox(height: 24,),
            const Text('Booking Successful!',style: TextStyle(
                fontWeight: FontWeight.bold,
                color: primaryColor,
                fontSize: 20
            ),),
            const SizedBox(height: 12,),
            const Text('You have successfully made the payment and book a service', textAlign: TextAlign.center,),
            const SizedBox(height: 16,),
            CustomButton(width: MediaQuery.of(context).size.width*0.6,
                height: 45,
                text: 'View', onTap: (){
              Get.back();
              onTab();
                }),
            const SizedBox(height: 32,),

          ],
        ),
      ),
    );
  });

}
