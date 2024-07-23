import 'package:flutter/material.dart';
import 'package:smart_sense/src/config/constant/app_colors.dart';


class FormFieldTitle extends StatelessWidget {
  final String title;
  const FormFieldTitle({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 10,
        left: 17,
        right: 10,
      ),
      child: Align(
          alignment: Alignment.topLeft,
          child: Text(
            title,
            style:  const TextStyle(
                color: blackColor, fontSize: 18, fontWeight: FontWeight.w600),
          )),
    );
  }
}
