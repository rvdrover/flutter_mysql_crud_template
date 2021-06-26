import 'package:flutter/material.dart';

class CustomTxtFeild extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final String lable;
  const CustomTxtFeild({
    Key? key,
    required this.controller,
    required this.hint,
    required this.lable,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 350,
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
                errorStyle: TextStyle(color: Color.fromRGBO(210, 101, 120, 1)),
                focusedErrorBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Color.fromRGBO(210, 101, 120, 1)),
                    borderRadius: BorderRadius.circular(15)),
                errorBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Color.fromRGBO(210, 101, 120, 1)),
                    borderRadius: BorderRadius.circular(15)),
                labelText: lable,
                hintText: hint,
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
              ),
      ),
    );
  }
}
