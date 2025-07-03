import 'package:flutter/material.dart';
import '../constants/colors.dart';

enum ButtonStyleType { filled, outlined }

class AppButton extends StatelessWidget {
  const AppButton.filled({
    Key? key,
    required this.onPressed,
    required this.label,
    this.color = AppColors.pinkPastel,
    this.textColor = Colors.white,
    this.width = double.infinity,
    this.height = 50.0,
    this.borderRadius = 12.0,
    this.icon,
    this.suffixIcon,
    this.disabled = false,
    this.fontSize = 16.0,
  })  : style = ButtonStyleType.filled,
        super(key: key);

  const AppButton.outlined({
    Key? key,
    required this.onPressed,
    required this.label,
    this.color = Colors.transparent,
    this.textColor = AppColors.pinkFanta,
    this.width = double.infinity,
    this.height = 50.0,
    this.borderRadius = 12.0,
    this.icon,
    this.suffixIcon,
    this.disabled = false,
    this.fontSize = 16.0,
  })  : style = ButtonStyleType.outlined,
        super(key: key);

  final VoidCallback? onPressed;
  final String label;
  final ButtonStyleType style;
  final Color color;
  final Color textColor;
  final double? width;
  final double height;
  final double borderRadius;
  final Widget? icon;
  final Widget? suffixIcon;
  final bool disabled;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: style == ButtonStyleType.filled
          ? ElevatedButton(
              onPressed: disabled ? null : onPressed,
              style: ElevatedButton.styleFrom(
                backgroundColor: color,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(borderRadius),
                ),
                elevation: 2,
              ),
              child: _buildContent(),
            )
          : OutlinedButton(
              onPressed: disabled ? null : onPressed,
              style: OutlinedButton.styleFrom(
                side: BorderSide(color: textColor),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(borderRadius),
                ),
              ),
              child: _buildContent(),
            ),
    );
  }

  Widget _buildContent() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        icon ?? const SizedBox.shrink(),
        if (icon != null && label.isNotEmpty) const SizedBox(width: 8),
        Text(
          label,
          style: TextStyle(
            color: textColor,
            fontSize: fontSize,
            fontWeight: FontWeight.w600,
          ),
        ),
        if (suffixIcon != null && label.isNotEmpty) const SizedBox(width: 8),
        suffixIcon ?? const SizedBox.shrink(),
      ],
    );
  }
}
