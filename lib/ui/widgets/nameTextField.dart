import 'package:flutter/material.dart';

class NameTextField extends StatefulWidget {
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;

  const NameTextField({
    Key? key,
    required this.controller,
    this.validator,
    this.onChanged,
  }) : super(key: key);

  @override
  State<NameTextField> createState() => _NameTextFieldState();
}

class _NameTextFieldState extends State<NameTextField> {

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      decoration: InputDecoration(
        labelText: 'username',
        hintText: 'Enter your username',
        prefixIcon: Icon(Icons.person),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
      validator: widget.validator,
      onChanged: widget.onChanged,
    );
  }
}
