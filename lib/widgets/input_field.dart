import 'package:flutter/material.dart';
import 'package:task_ku_mobile_app/shared/theme.dart';

class InputField extends StatelessWidget {
  String? hintText;
  TextEditingController? controller;
  InputField({Key? key, this.hintText, this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: double.infinity,
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
            contentPadding: EdgeInsets.only(left: 10),
            hintText: hintText,
            hintStyle:
                regularStyle.copyWith(color: Color(0xffAAAAAA), fontSize: 14),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8))),
      ),
    );
  }
}
