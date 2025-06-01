import 'package:base_project/core/theme/app_colors.dart' show AppColors;
import 'package:flutter/material.dart';
import 'package:base_project/core/helpers/dimensions.dart';

import '../core/helpers/utils.dart';
import 'app_text.dart';

class AppDropDownMenu extends StatefulWidget {
  const AppDropDownMenu({
    Key? key,
    required this.hint,
    required this.onChange,
    required this.items,
    this.value,
    this.modeling = false,
    this.fillColor = AppColors.background,
    this.label,
    this.validator,
  }) : super(key: key);

  final String hint;
  final dynamic value;
  final Function(dynamic) onChange;
  final List items;
  final bool modeling;
  final Color fillColor;
  final String? label;
  final String? Function(dynamic)? validator;

  @override
  State<AppDropDownMenu> createState() => _AppDropDownMenuState();
}

class _AppDropDownMenuState extends State<AppDropDownMenu> {
  dynamic value;

  @override
  void initState() {
    value = widget.value;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.label != null)
          Padding(
            padding: EdgeInsets.only(bottom: 8.height),
            child: AppText(
              title: widget.label!,
              color: AppColors.secondary,
            ),
          ),
        DropdownButtonFormField(
          isExpanded: false,
          isDense: true,
          validator: widget.validator,
          decoration: InputDecoration(
            fillColor: widget.fillColor,
            filled: true,
            hintText: widget.hint,
            hintStyle: TextStyle(
              color: AppColors.black,
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
            contentPadding:
                EdgeInsets.symmetric(horizontal: 12.width, vertical: 14.height),
            border: _border(AppColors.lightGray),
            enabledBorder: _border(AppColors.lightGray),
            focusedBorder: _border(AppColors.secondary),
            errorBorder: _border(AppColors.red),
            focusedErrorBorder: _border(AppColors.secondary),
          ),
          hint: Text(
            widget.hint,
            style: TextStyle(
              color: AppColors.gray,
              fontSize: 16,
              fontWeight: FontWeight.w400,
            ),
          ),
          value: value,
          iconSize: 30,
          iconEnabledColor: AppColors.gray,
          icon: Icon(
            Icons.keyboard_arrow_down_rounded,
          ),
          iconDisabledColor: AppColors.lightGray,
          items: widget.items
              .map((e) => DropdownMenuItem(
                    child: Text(widget.modeling ? e.name : e.toString()),
                    value: e,
                  ))
              .toList(),
          onChanged: (value) {
            this.value = value;
            setState(() {});
            widget.onChange(value);
            Utils.dismissKeyboard();
          },
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

  double get _radius => 16;
}
