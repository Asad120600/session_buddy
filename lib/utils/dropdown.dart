import 'package:flutter/material.dart';

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
    final ThemeData theme = Theme.of(context);
    final ColorScheme colorScheme = theme.colorScheme;

    return GestureDetector(
      onTap: () {
        setState(() {
          isFocused = true;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        decoration: BoxDecoration(
          border: Border.all(
            color: isFocused
                ? Colors.transparent
                : theme.inputDecorationTheme.border?.borderSide.color ??
                    colorScheme.outline,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            hint: Text(
              widget.hintText,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: colorScheme.secondary,
              ),
            ),
            isExpanded: true,
            icon: Icon(Icons.arrow_drop_down, color: theme.iconTheme.color),
            value: selectedValue,
            items: widget.items.map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(120),
                    color: Colors.transparent,
                  ),
                  child: Text(
                    value,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      fontSize: 14,
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
