// utils/text_field.dart
import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  final String hintText;
  final TextEditingController controller;
  final bool isPassword;
  final bool? obscureText;
  final Widget? suffixIcon;

  const CustomTextField({
    super.key,
    required this.hintText,
    required this.controller,
    this.isPassword = false,
    this.obscureText,
    this.suffixIcon,
  });

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  late bool _isObscured;

  @override
  void initState() {
    super.initState();
    _isObscured = widget.obscureText ?? widget.isPassword;
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final ColorScheme colorScheme = theme.colorScheme;

    return TextField(
      controller: widget.controller,
      obscureText: widget.isPassword ? _isObscured : false,
      decoration: InputDecoration(
        hintText: widget.hintText,
        hintStyle: TextStyle(color: colorScheme.secondary),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: theme.inputDecorationTheme.border?.borderSide ??
              BorderSide(color: colorScheme.outline),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: theme.inputDecorationTheme.enabledBorder?.borderSide ??
              BorderSide(color: colorScheme.outline),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide(color: colorScheme.primary),
        ),
        suffixIcon: widget.suffixIcon ??
            (widget.isPassword
                ? IconButton(
                    icon: Icon(
                      _isObscured
                          ? Icons.visibility_off_outlined
                          : Icons.visibility_outlined,
                      color: colorScheme.primary,
                    ),
                    onPressed: () {
                      setState(() {
                        _isObscured = !_isObscured;
                      });
                    },
                  )
                : null),
      ),
    );
  }
}
