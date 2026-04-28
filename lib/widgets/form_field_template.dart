import 'package:flutter/material.dart';

class FormFieldTemplate extends StatelessWidget {
  const FormFieldTemplate({
    super.key,
    this.hintText,
    this.controller,
    this.validator,
  });

  final String? hintText;
  final TextEditingController? controller;
  final String? Function(String? value)? validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        border: OutlineInputBorder(borderSide: BorderSide.none),
        filled: true,
        fillColor: Theme.of(context).colorScheme.surfaceContainer,
        hintText: hintText,
      ),
      controller: controller,
      validator: validator,
    );
  }
}
