import 'package:base_project/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:base_project/core/helpers/dimensions.dart';
import 'package:base_project/widgets/app_text.dart';

import '../core/helpers/utils.dart';

class ArabicToEnglishNumbersFormatter extends TextInputFormatter {
  final arabicToEnglishDigits = {
    '٠': '0',
    '١': '1',
    '٢': '2',
    '٣': '3',
    '٤': '4',
    '٥': '5',
    '٦': '6',
    '٧': '7',
    '٨': '8',
    '٩': '9'
  };

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    String newText = newValue.text;

    arabicToEnglishDigits.forEach((arabic, english) {
      newText = newText.replaceAll(arabic, english);
    });

    return newValue.copyWith(
      text: newText,
      selection: newValue.selection,
    );
  }
}

class AppTextField extends StatefulWidget {
  const AppTextField({
    super.key,
    this.hint,
    this.validator,
    this.textInputAction = TextInputAction.next,
    this.inputType = TextInputType.text,
    this.onTap,
    this.trailing,
    this.leading,
    this.label,
    this.maxLines = 1,
    this.borderColor,
    this.fillColor = Colors.white,
    this.onSaved,
    this.onChanged,
    this.controller,
    this.secure = false,
    this.hintColor,
    this.initialValue,
    this.maxLength,
    this.readOnly = false,
    this.inputFormatters,
    this.upperTitle,
    this.upperHint,
    this.suffixIcon,
  });

  final String? hint, upperTitle, upperHint;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final TextInputAction textInputAction;
  final TextInputType inputType;
  final VoidCallback? onTap;
  final Widget? trailing;
  final Widget? leading;
  final String? label;
  final int maxLines;
  final int? maxLength;
  final Color? borderColor;
  final Color fillColor;
  final bool secure;
  final bool readOnly;
  final void Function(String?)? onSaved;
  final TextEditingController? controller;
  final Color? hintColor;
  final String? initialValue;
  final List<TextInputFormatter>? inputFormatters;
  final Widget? suffixIcon;
  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  bool isHidden = true;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.label != null)
          Padding(
            padding: EdgeInsets.only(bottom: 8.height),
            child: AppText(
              title: widget.label!,
              fontSize: 14,
              color: Colors.black,
            ),
          ),
        if (widget.upperTitle != null) ...[
          AppText(
            title: widget.upperTitle!,
            fontSize: 12,
            fontWeight: FontWeight.w300,
          ),
          SizedBox(
            height: 4.h,
          ),
        ],
        if (widget.upperHint != null) ...[
          AppText(
            title: widget.upperHint!,
            fontSize: 10,
            color: AppColors.gray,
          ),
        ],
        SizedBox(
          height: 12.h,
        ),
        InkWell(
          radius: _radius,
          onTap: widget.onTap != null
              ? () {
                  Utils.dismissKeyboard();
                  widget.onTap!();
                }
              : null,
          borderRadius: BorderRadius.circular(_radius),
          child: AbsorbPointer(
            absorbing: widget.onTap != null || widget.readOnly,
            child: Container(
              child: TextFormField(
                readOnly: widget.readOnly,
                initialValue: widget.initialValue,
                controller: widget.controller,
                inputFormatters: [
                  if (widget.inputType == TextInputType.phone)
                    FilteringTextInputFormatter.allow(
                        //allow arabic numbers too
                        RegExp(r'[\d\u0660-\u0669]+')),
                  if (widget.inputType == TextInputType.visiblePassword)
                    FilteringTextInputFormatter.deny(RegExp(r'\s')),
                  //convert arabic numbers to english
                  ArabicToEnglishNumbersFormatter(),
                  ...(widget.inputFormatters ?? []),
                ],
                cursorColor: AppColors.primary,
                cursorHeight: 30,
                validator: widget.validator,
                onChanged: widget.onChanged,
                textInputAction: TextInputAction.done,
                keyboardType: widget.inputType,
                maxLines: widget.maxLines,
                maxLength: widget.maxLength,
                onSaved: (v) {
                  v = Utils.replaceArabicNumber(v!);
                  if (widget.onSaved != null) widget.onSaved!(v);
                },
                style: TextStyle(
                  color: Colors.black,
                ),
                obscureText: widget.secure ? isHidden : false,
                decoration: InputDecoration(
                  hintText: widget.hint ?? '',
                  counterText: "",
                  fillColor: widget.fillColor,
                  filled: true,
                  hintStyle: TextStyle(
                    color: widget.hintColor ?? const Color(0xFF7C7C7C),
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                  suffixIcon: SizedBox(
                    width: 24,
                    height: 24,
                    child: widget.secure
                        ? GestureDetector(
                            onTap: () {
                              setState(() {
                                isHidden = !isHidden;
                              });
                            },
                            child: Icon(
                              isHidden
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              color: AppColors.primary,
                              size: 24,
                            ),
                          )
                        : widget.trailing,
                  ),
                  prefixIcon: widget.leading != null ? widget.leading : null,
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 12.width,
                    vertical: MediaQuery.of(context).size.width > 600
                        ? 26
                        : 10.height,
                  ),
                  border: _border(
                      widget.borderColor ?? Colors.black.withOpacity(0.06)),
                  disabledBorder: _border(
                      widget.borderColor ?? Colors.black.withOpacity(0.06)),
                  enabledBorder: _border(
                      widget.borderColor ?? Colors.black.withOpacity(0.06)),
                  focusedBorder: _border(AppColors.primary, width: 1),
                  errorBorder: _border(AppColors.red),
                  focusedErrorBorder: _border(AppColors.primary, width: 1),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  InputBorder _border(Color color, {double width = 1}) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(_radius),
      borderSide: BorderSide(
        color: color,
        width: width,
      ),
    );
  }

  double get _radius => widget.maxLines > 1 ? 10 : 10;
}
