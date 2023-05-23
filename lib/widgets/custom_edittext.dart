import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:profixer_admin/helpers/custom_colors.dart';

class CustomEditText extends StatelessWidget {
  String hintText;
  Widget? suffixIcon, prefixIcon;
  bool isDense, obscureText,readOnly,showCursor;
  double? borderRadius;
  TextInputType? keyboardType;
  int? maxLength,maxLines,minLines;
  TextAlign? textAlign;
  Function(String)? onChanged;
  Function()? onTab;
  TextEditingController? controller;
  List<TextInputFormatter>? inputFormatters;
  CustomEditText(
      {required this.hintText,
        this.maxLength,
        this.maxLines = 1,
        this.minLines = 1,
        required this.controller,
        this.suffixIcon,
        this.prefixIcon,
        this.isDense = true,
        this.obscureText = false,
        this.readOnly = false,
        this.showCursor = true,
        this.borderRadius,
        this.keyboardType,
        this.onTab,
        this.onChanged,
        this.textAlign,
        this.inputFormatters,
        Key? key,})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(hintText,style: const TextStyle(
          color: hintColor,
          fontSize: 12
        ),),
        TextFormField(
          onChanged: onChanged,
          maxLines: maxLines,
          minLines: minLines,
          textAlign: textAlign ?? TextAlign.start,
          keyboardType: keyboardType,
          maxLength: maxLength,
          obscureText: obscureText,
          controller: controller,
          readOnly: readOnly,
          onTap: onTab,
          showCursor: showCursor,
          // cursorColor: Colors.black,
          cursorHeight: 28,
          style: const TextStyle(fontSize: 16),
          inputFormatters: inputFormatters ?? [],
          decoration: InputDecoration(
              isDense: isDense,
              suffixIcon: suffixIcon,
              prefixIcon: prefixIcon,
              counter: null,
              counterText: '',
            focusColor: Colors.black,
            contentPadding: const EdgeInsets.symmetric(horizontal: 8,vertical: 2),
            // border: const UnderlineInputBorder(borderSide: BorderSide(color: Colors.black)),
            // focusedBorder: const UnderlineInputBorder(borderSide: BorderSide(color: Colors.black)),
             ),
        ),
      ],
    );
  }
}
