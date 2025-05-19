import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomDropdown extends StatefulWidget {
  final String hintText;
  final List<String> items;
  final ValueChanged<String?> onChanged;

  const CustomDropdown({
    super.key,
    required this.hintText,
    required this.items,
    required this.onChanged,
  });

  @override
  _CustomDropdownState createState() => _CustomDropdownState();
}

class _CustomDropdownState extends State<CustomDropdown> {
  String? selectedValue;
  bool isFocused = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return GestureDetector(
      onTap: () => setState(() => isFocused = true),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 25.w),
        decoration: BoxDecoration(
          border: Border.all(
            color: isFocused
                ? Colors.transparent
                : theme.inputDecorationTheme.border?.borderSide.color ??
                    colorScheme.outline,
          ),
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            hint: Text(
              widget.hintText,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: colorScheme.secondary,
                fontSize: 14.sp,
              ),
            ),
            isExpanded: true,
            icon: Icon(Icons.arrow_drop_down, size: 24.sp, color: theme.iconTheme.color),
            value: selectedValue,
            items: widget.items.map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 10.w),
                  child: Text(
                    value,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              );
            }).toList(),
            onChanged: (value) {
              setState(() {
                selectedValue = value;
                isFocused = false;
              });
              widget.onChanged(value);
            },
          ),
        ),
      ),
    );
  }
}
