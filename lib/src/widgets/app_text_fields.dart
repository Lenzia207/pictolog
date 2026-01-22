import 'package:flutter/material.dart';
import '../constants/app_style.dart';
import '../constants/app_text_style.dart';
import '../theme/theme.dart';

enum AppTextFieldType {
  oneLiner,
  multiLines,
}

class AppTextField extends StatelessWidget {
  const AppTextField({
    super.key,
    required this.controller,
    required this.labelText,
    required this.type,
  });

  final TextEditingController controller;
  final String labelText;
  final AppTextFieldType type;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      maxLines: switch (type) {
        AppTextFieldType.oneLiner => 1,
        AppTextFieldType.multiLines => 7,
      },
      cursorColor: AppColor.accentGreen,
      decoration: InputDecoration(
        labelText: labelText,
        alignLabelWithHint: type == AppTextFieldType.multiLines,
        hintStyle: AppTextStyle.bodyMedium.copyWith(
          color: AppColor.black,
        ),
        filled: true,
        fillColor: context.colors.surface,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(p12),
          borderSide: BorderSide(
            color: context.colors.primary,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(p12),
          borderSide: const BorderSide(
            color: AppColor.accentGreen,
            width: 2,
          ),
        ),
        labelStyle: TextStyle(
          color: context.colors.textSecondary,
        ),
        floatingLabelBehavior: FloatingLabelBehavior.never,
      ),
    );
  }
}
