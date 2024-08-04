import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomInputField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final Widget? sufix;
  final int maxLines;
  final int minLines;

  const CustomInputField(
      {super.key,
      required this.controller,
      required this.labelText,
      this.sufix,
      this.minLines = 1,
      this.maxLines = 1});

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
        style: GoogleFonts.montserrat(
            color: Theme.of(context).colorScheme.scrim
        ),
        controller: controller,
        cursorColor: Theme.of(context).colorScheme.scrim,
        decoration: InputDecoration(
          filled: true,
          fillColor: Theme.of(context).colorScheme.surfaceBright,
          labelStyle: GoogleFonts.jost(
              color:  Theme.of(context).colorScheme.scrim
          ),
          labelText: labelText,
          suffixIcon: sufix,
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide(color: Theme.of(context).colorScheme.scrim)),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide(color: Theme.of(context).colorScheme.surfaceBright)
          ),
        ),
      ),
    );
  }
}
