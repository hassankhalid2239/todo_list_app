import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomInputField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final Widget? sufix;
  final int maxLines;
  final int minLines;


  CustomInputField({
    required this.controller,
    required this.labelText,

    required Color cursorColor,
    required Color borderColor,
    this.sufix,
    this.minLines=1,
    this.maxLines=1
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        maxLines: maxLines,
        minLines: minLines,
        validator: (value) {
          if (value!.isEmpty) {
            return 'Please enter $labelText!';
          } else {
            return null;
          }
        },
        controller: controller,
        decoration: InputDecoration(
          labelText: labelText,

          suffixIcon: sufix,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
      ),
    );
  }
}