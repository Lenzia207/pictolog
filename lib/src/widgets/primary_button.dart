import 'package:flutter/material.dart';
import '../constants/app_style.dart';
import '../constants/app_text_style.dart';
import '../theme/theme.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    super.key,
    required this.onPressed,
    required this.label,
    this.backgroundColor,
    this.textColor,
    this.isLoading = false,
  });

  final VoidCallback onPressed;
  final String label;
  final Color? backgroundColor;
  final Color? textColor;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 56, // Fixed height for consistency
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor ?? context.colors.primary,
          foregroundColor: textColor ?? context.colors.surface,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(100), // Fully rounded caps
          ),
          padding: const EdgeInsets.symmetric(horizontal: p20),
        ),
        child: isLoading
            ? SizedBox(
                height: 24,
                width: 24,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    context.colors.surface,
                  ),
                ),
              )
            : Text(
                label,
                style: AppTextStyle.button.copyWith(
                  color: textColor ?? context.colors.surface,
                ),
              ),
      ),
    );
  }
}
