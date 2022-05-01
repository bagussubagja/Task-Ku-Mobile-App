import 'package:flutter/material.dart';
import 'package:task_ku_mobile_app/shared/theme.dart';

class InputField extends StatelessWidget {
  String titleText = "";
  String? hintText;
  TextEditingController? controller;
  Widget? widget;
  Widget? prefixIcon;
  Function()? onTap;
  bool? obsecureText;
  InputField(
      {Key? key,
      required this.titleText,
      this.hintText,
      this.controller,
      this.widget,
      this.onTap,
      this.prefixIcon,
      this.obsecureText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        titleText.isEmpty
            ? SizedBox.shrink()
            : Text(
                titleText,
                style: TextStyle(fontSize: 14),
              ),
        SizedBox(
          height: 5,
        ),
        Container(
          height: 50,
          width: double.infinity,
          child: Row(
            children: [
              Expanded(
                child: TextFormField(
                  obscureText: obsecureText ?? false,
                  onTap: onTap,
                  readOnly: widget == null ? false : true,
                  controller: controller,
                  decoration: InputDecoration(
                    prefixIcon: prefixIcon,
                    contentPadding: EdgeInsets.only(left: 10),
                    hintText: hintText,
                    hintStyle: regularStyle.copyWith(
                        color: Color(0xffAAAAAA), fontSize: 14),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
              widget == null
                  ? SizedBox.shrink()
                  : Container(
                      child: widget,
                    )
            ],
          ),
        ),
      ],
    );
  }
}
