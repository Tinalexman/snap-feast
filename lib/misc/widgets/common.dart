import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:snapfeast/misc/constants.dart';

const Widget loader = SpinKitDancingSquare(
  color: p400,
  size: 35,
);
const Widget whiteLoader = SpinKitDancingSquare(
  color: Colors.white,
  size: 35,
);

class Popup extends StatelessWidget {
  const Popup({
    super.key,
  });

  @override
  Widget build(BuildContext context) => const AlertDialog(
        backgroundColor: Colors.transparent,
        elevation: 0,
        content: CenteredPopup(),
      );
}

class CenteredPopup extends StatelessWidget {
  const CenteredPopup({super.key});

  @override
  Widget build(BuildContext context) => const Center(child: loader);
}

class SpecialForm extends StatelessWidget {
  final Widget? prefix;
  final Widget? suffix;
  final String? hint;
  final Color? fillColor;
  final Color? borderColor;
  final EdgeInsets? padding;
  final bool obscure;
  final bool autoValidate;
  final FocusNode? focus;
  final bool autoFocus;
  final Function? onChange;
  final Function? onActionPressed;
  final Function? onValidate;
  final Function? onSave;
  final BorderRadius? radius;
  final TextEditingController controller;
  final TextInputType type;
  final TextInputAction action;
  final TextStyle? hintStyle;
  final bool readOnly;
  final int maxLines;
  final double width;
  final double height;

  const SpecialForm({
    super.key,
    required this.controller,
    required this.width,
    required this.height,
    this.fillColor,
    this.borderColor,
    this.padding,
    this.hintStyle,
    this.focus,
    this.autoFocus = false,
    this.readOnly = false,
    this.obscure = false,
    this.autoValidate = false,
    this.type = TextInputType.text,
    this.action = TextInputAction.none,
    this.onActionPressed,
    this.onChange,
    this.onValidate,
    this.onSave,
    this.radius,
    this.hint,
    this.prefix,
    this.suffix,
    this.maxLines = 1,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: TextFormField(
        autovalidateMode:
            autoValidate ? AutovalidateMode.always : AutovalidateMode.disabled,
        maxLines: maxLines,
        focusNode: focus,
        autofocus: autoFocus,
        controller: controller,
        obscureText: obscure,
        keyboardType: type,
        textInputAction: action,
        readOnly: readOnly,
        onEditingComplete: () {
          if (onActionPressed != null) {
            onActionPressed!(controller.text);
          }
        },
        cursorColor: p400,
        style: context.textTheme.bodyMedium!.copyWith(
          fontWeight: FontWeight.w500,
          fontFamily: "Montserrat",
        ),
        decoration: InputDecoration(
          errorMaxLines: 1,
          errorStyle: const TextStyle(height: 0, fontSize: 0),
          fillColor: neutral2,
          filled: true,
          contentPadding: padding ??
              EdgeInsets.symmetric(
                horizontal: 15.w,
                vertical: maxLines == 1 ? 5.h : 10.h,
              ),
          prefixIcon: prefix != null
              ? SizedBox(
                  width: height,
                  height: height,
                  child: Center(
                    child: prefix,
                  ),
                )
              : null,
          suffixIcon: suffix != null
              ? SizedBox(
                  width: height,
                  height: height,
                  child: Center(child: suffix),
                )
              : null,
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(maxLines > 1 ? 15.r : 10.r),
            borderSide: const BorderSide(color: Colors.transparent),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(maxLines > 1 ? 15.r : 10.r),
            borderSide: const BorderSide(color: Colors.transparent),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(maxLines > 1 ? 15.r : 10.r),
            borderSide: const BorderSide(color: Colors.transparent),
          ),
          hintText: hint,
          hintStyle: hintStyle ??
              context.textTheme.bodyMedium!.copyWith(
                fontWeight: FontWeight.w400,
                color: p150,
                fontFamily: "Montserrat",
              ),
        ),
        onChanged: (value) {
          if (onChange == null) return;
          onChange!(value);
        },
        validator: (value) {
          if (onValidate == null) return null;
          return onValidate!(value);
        },
        onSaved: (value) {
          if (onSave == null) return;
          onSave!(value);
        },
      ),
    );
  }
}

class ComboBox extends StatelessWidget {
  final String hint;
  final String? value;
  final List<String> dropdownItems;
  final ValueChanged<String?>? onChanged;
  final DropdownButtonBuilder? selectedItemBuilder;
  final Alignment? hintAlignment;
  final Alignment? valueAlignment;
  final double? buttonHeight, buttonWidth;
  final EdgeInsetsGeometry? buttonPadding;
  final BoxDecoration? buttonDecoration;
  final int? buttonElevation;
  final Widget? icon;
  final double? iconSize;
  final Color? iconEnabledColor;
  final Color? iconDisabledColor;
  final double? itemHeight;
  final EdgeInsetsGeometry? itemPadding;
  final double? dropdownHeight, dropdownWidth;
  final EdgeInsetsGeometry? dropdownPadding;
  final BoxDecoration? dropdownDecoration;
  final int? dropdownElevation;
  final Radius? scrollbarRadius;
  final double? scrollbarThickness;
  final bool? scrollbarAlwaysShow;
  final Offset offset;
  final bool noDecoration;

  const ComboBox({
    required this.hint,
    required this.value,
    required this.dropdownItems,
    required this.onChanged,
    this.noDecoration = false,
    this.selectedItemBuilder,
    this.hintAlignment,
    this.valueAlignment,
    this.buttonHeight,
    this.buttonWidth,
    this.buttonPadding,
    this.buttonDecoration,
    this.buttonElevation,
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
    this.dropdownElevation,
    this.scrollbarRadius,
    this.scrollbarThickness,
    this.scrollbarAlwaysShow,
    this.offset = Offset.zero,
    super.key,
  });

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
            style: context.textTheme.bodyLarge!.copyWith(
              fontWeight: FontWeight.w500,
              color: Colors.white60,
            ),
          ),
        ),
        value: value,
        items: dropdownItems
            .map(
              (String item) => DropdownMenuItem<String>(
                value: item,
                child: Container(
                  alignment: valueAlignment,
                  child: Text(
                    item,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: context.textTheme.bodyLarge!
                        .copyWith(fontWeight: FontWeight.w500),
                  ),
                ),
              ),
            )
            .toList(),
        onChanged: onChanged,
        selectedItemBuilder: selectedItemBuilder,
        buttonStyleData: ButtonStyleData(
          height: (noDecoration) ? null : buttonHeight ?? 40,
          width: (noDecoration) ? 80 : buttonWidth ?? 140,
          padding: (noDecoration)
              ? null
              : buttonPadding ?? const EdgeInsets.only(left: 14, right: 14),
          decoration: (noDecoration)
              ? null
              : buttonDecoration ??
                  BoxDecoration(
                    borderRadius: BorderRadius.circular(
                        buttonHeight == null ? 20 : buttonHeight! * 0.5),
                    border: Border.all(color: neutral2),
                  ),
          elevation: buttonElevation,
        ),
        iconStyleData: IconStyleData(
          icon: icon ?? const Icon(Icons.arrow_forward_ios_outlined),
          iconSize: iconSize ?? 12,
          iconEnabledColor: iconEnabledColor,
          iconDisabledColor: iconDisabledColor,
        ),
        dropdownStyleData: DropdownStyleData(
          //Max height for the dropdown menu & becoming scrollable if there are more items. If you pass Null it will take max height possible for the items.
          maxHeight: dropdownHeight ?? 200,
          width: dropdownWidth ?? 140,
          padding: dropdownPadding,
          decoration: dropdownDecoration ??
              BoxDecoration(
                borderRadius: BorderRadius.circular(8.r),
              ),
          elevation: dropdownElevation ?? 8,
          //Null or Offset(0, 0) will open just under the button. You can edit as you want.
          offset: offset,
          scrollbarTheme: ScrollbarThemeData(
            radius: scrollbarRadius ?? const Radius.circular(40),
            thickness: scrollbarThickness != null
                ? MaterialStateProperty.all<double>(scrollbarThickness!)
                : null,
            thumbVisibility: scrollbarAlwaysShow != null
                ? MaterialStateProperty.all<bool>(scrollbarAlwaysShow!)
                : null,
          ),
        ),
        menuItemStyleData: MenuItemStyleData(
          height: itemHeight ?? 40,
          padding: itemPadding ?? const EdgeInsets.only(left: 14, right: 14),
        ),
      ),
    );
  }
}

class ImageDialog extends StatelessWidget {
  final String text;
  final VoidCallback onProceed;

  const ImageDialog({
    super.key,
    required this.text,
    required this.onProceed,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15.r),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Note",
                style: context.textTheme.headlineSmall!.copyWith(
                  fontWeight: FontWeight.bold,
                  fontFamily: "Montserrat",
                ),
              ),
              SizedBox(height: 20.h),
              Text(
                text,
                style: context.textTheme.bodyMedium!.copyWith(
                  fontWeight: FontWeight.w500,
                  fontFamily: "Montserrat",
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () => Navigator.of(context).pop(),
                    child: Text(
                      "Cancel",
                      style: context.textTheme.bodyMedium!.copyWith(
                        fontFamily: "Montserrat",
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pop();
                      onProceed();
                    },
                    child: Text(
                      "Proceed",
                      style: context.textTheme.bodyMedium!.copyWith(
                        fontWeight: FontWeight.w700,
                        fontFamily: "Montserrat",
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
