import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:profixer_admin/helpers/custom_colors.dart';
import 'package:profixer_admin/widgets/custom_appbar.dart';
import 'package:profixer_admin/widgets/custom_button.dart';
import 'package:profixer_admin/widgets/custom_edittext.dart';

class LanguageScreen extends StatefulWidget {
  const LanguageScreen({Key? key}) : super(key: key);

  @override
  State<LanguageScreen> createState() => _LanguageScreenState();
}

class _LanguageScreenState extends State<LanguageScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const SizedBox(
              height: 80,
            ),
            const Text(
              'Choose Your',
              style: TextStyle(
                  color: blackColor, fontWeight: FontWeight.w800, fontSize: 20),
            ),
            const Text(
              'Language',
              style: TextStyle(
                  color: primaryColor,
                  fontWeight: FontWeight.w800,
                  fontSize: 20),
            ),
            const SizedBox(
              height: 16,
            ),
            const Text(
              'By Selecting this, all the menu’s, Text will be Changed in your preferred language',
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 64,
            ),
            _buildLanguageButton('English'),
            const SizedBox(
              height: 24,
            ),
            _buildLanguageButton('Arabic'),
            const SizedBox(
              height: 64,
            ),
            CustomEditText(hintText: 'Email/Mobile Number', controller: TextEditingController()),
            const SizedBox(height: 32,),
            Row(
              children: [
                Expanded(
                    child: CustomButton(
                  text: 'SKIP',
                  onTap: () {},
                  borderRadius: 24,
                  border: Border.all(color: Colors.black),
                  btnColor: Colors.white,
                  textColor: Colors.black,
                )),
                const SizedBox(width: 16,),
                Expanded(
                    child: CustomButton(
                  text: 'GET STARTED',
                  onTap: () {},
                )),
              ],
            ),
          ],
        ),
      ),
    );
  }

  _buildLanguageButton(String title) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 55,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: Colors.grey.shade300),
            boxShadow: [
              BoxShadow(
                  color: Colors.grey.shade100,
                  spreadRadius: 1,
                  blurRadius: 3,
                  offset: const Offset(0, 2))
            ]),
        child: Center(
            child: Text(
          title,
          style: const TextStyle(color: primaryColor, fontSize: 15),
        )),
      ),
    );
  }
}
