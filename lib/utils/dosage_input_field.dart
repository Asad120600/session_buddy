import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DosageInputField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;

  const DosageInputField({
    super.key,
    required this.controller,
    this.hintText = "Dosage",
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: theme.inputDecorationTheme.border?.borderSide.color ??
              colorScheme.outline,
        ),
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: controller,
              keyboardType: TextInputType.number,
              style: theme.textTheme.bodyMedium?.copyWith(fontSize: 14.sp),
              decoration: InputDecoration(
                hintText: hintText,
                hintStyle: TextStyle(color: colorScheme.secondary),
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 10.w, vertical: 15.h),
                border: InputBorder.none,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.w),
            child: Text(
              "mg",
              style: theme.textTheme.bodyMedium?.copyWith(fontSize: 14.sp),
            ),
          ),
        ],
      ),
    );
  }
}
