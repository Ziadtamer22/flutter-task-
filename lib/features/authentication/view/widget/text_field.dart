import 'package:flutter/material.dart';

class CustomTextFailed extends StatefulWidget {
  final Function(String)? onChanged;
  final Function(String?) validator;
  final bool isPassword;
  final String hintText;

  const CustomTextFailed({
    super.key,
    this.onChanged,
    required this.validator,
    this.isPassword = false,
    required this.hintText,
  });

  @override
  State<CustomTextFailed> createState() => _CustomTextFailedState();
}

class _CustomTextFailedState extends State<CustomTextFailed> {
  bool _obscureText = true;

  void _toggleVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: widget.isPassword && _obscureText,
      onChanged: widget.onChanged,
      decoration: InputDecoration(
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        hintText: widget.hintText,
        suffixIcon: widget.isPassword
            ? IconButton(
                icon: Icon(
                  _obscureText ? Icons.visibility_off : Icons.visibility,
                ),
                onPressed: _toggleVisibility,
              )
            : null,
      ),
      validator: (value) => widget.validator(value),
    );
  }
}
