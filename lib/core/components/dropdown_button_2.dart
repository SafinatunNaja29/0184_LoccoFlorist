import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

/// Custom DropdownButton2 reusable component
class CustomDropdownButton2 extends StatelessWidget {
  const CustomDropdownButton2({
    Key? key,
    required this.hint,
    required this.value,
    required this.items,
    required this.onChanged,
    this.hintAlignment,
    this.valueAlignment,
    this.buttonHeight,
    this.buttonWidth,
    this.buttonPadding,
    this.buttonDecoration,
    this.icon,
    this.iconSize,
    this.iconEnabledColor,
    this.iconDisabledColor,
    this.itemHeight,
    this.itemPadding,
    this.dropdownHeight,
    this.dropdownWidth,
    this.dropdownPadding,
    this.dropdownDecoration,
    this.scrollbarRadius,
    this.scrollbarThickness,
    this.scrollbarAlwaysShow,
    this.offset = Offset.zero,
  }) : super(key: key);

  final String hint;
  final String? value;
  final List<String> items;
  final ValueChanged<String?>? onChanged;

  final Alignment? hintAlignment;
  final Alignment? valueAlignment;

  final double? buttonHeight;
  final double? buttonWidth;
  final EdgeInsetsGeometry? buttonPadding;
  final BoxDecoration? buttonDecoration;

  final Widget? icon;
  final double? iconSize;
  final Color? iconEnabledColor;
  final Color? iconDisabledColor;

  final double? itemHeight;
  final EdgeInsetsGeometry? itemPadding;

  final double? dropdownHeight;
  final double? dropdownWidth;
  final EdgeInsetsGeometry? dropdownPadding;
  final BoxDecoration? dropdownDecoration;

  final Radius? scrollbarRadius;
  final double? scrollbarThickness;
  final bool? scrollbarAlwaysShow;

  final Offset offset;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton2<String>(
        isExpanded: true,
        hint: Container(
          alignment: hintAlignment,
          child: Text(
            hint,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            style: TextStyle(
              fontSize: 14,
              color: Theme.of(context).hintColor,
            ),
          ),
        ),
        value: value,
        items: items
            .map((String item) => DropdownMenuItem<String>(
                  value: item,
                  child: Container(
                    alignment: valueAlignment,
                    child: Text(
                      item,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: const TextStyle(fontSize: 14),
                    ),
                  ),
                ))
            .toList(),
        onChanged: onChanged,
        buttonStyleData: ButtonStyleData(
          height: buttonHeight ?? 48,
          width: buttonWidth ?? double.infinity,
          padding:
              buttonPadding ?? const EdgeInsets.symmetric(horizontal: 12),
          decoration: buttonDecoration ??
              BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey),
              ),
        ),
        iconStyleData: IconStyleData(
          icon: icon ?? const Icon(Icons.arrow_drop_down),
          iconSize: iconSize ?? 24,
          iconEnabledColor: iconEnabledColor,
          iconDisabledColor: iconDisabledColor,
        ),
        dropdownStyleData: DropdownStyleData(
          maxHeight: dropdownHeight ?? 200,
          width: dropdownWidth ?? null,
          padding: dropdownPadding,
          decoration: dropdownDecoration ??
              BoxDecoration(
                borderRadius: BorderRadius.circular(12),
              ),
          offset: offset,
          scrollbarTheme: ScrollbarThemeData(
            radius: scrollbarRadius ?? const Radius.circular(40),
            thickness: scrollbarThickness != null
                ? MaterialStateProperty.all(scrollbarThickness!)
                : null,
            thumbVisibility: scrollbarAlwaysShow != null
                ? MaterialStateProperty.all(scrollbarAlwaysShow!)
                : null,
          ),
        ),
        menuItemStyleData: MenuItemStyleData(
          height: itemHeight ?? 48,
          padding:
              itemPadding ?? const EdgeInsets.symmetric(horizontal: 12),
        ),
      ),
    );
  }
}
