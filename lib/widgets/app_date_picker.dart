import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:base_project/core/routing/app_router.dart';

import 'package:base_project/widgets/app_button.dart';
import 'package:base_project/widgets/app_text.dart';

class AppDatePicker extends StatefulWidget {
  const AppDatePicker({Key? key, required this.title}) : super(key: key);

  final String title;

  static Future<DateTime?> show({required String title}) {
    return showModalBottomSheet(
      context: navigatorKey.currentContext!,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
      ),
      builder: (context) {
        return AppDatePicker(
          title: title,
        );
      },
    );
  }

  @override
  State<AppDatePicker> createState() => _AppDatePickerState();
}

class _AppDatePickerState extends State<AppDatePicker> {
  final now = DateTime.now();
  DateTime? selectedDate;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BottomSheet(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        onClosing: () {},
        builder: (context) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 20),
              AppText(
                title: widget.title,
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
              Expanded(
                child: CupertinoDatePicker(
                  itemExtent: 50,
                  minimumDate: now,
                  onDateTimeChanged: (value) => selectedDate = value,
                  mode: CupertinoDatePickerMode.date,
                  // onSelectedItemChanged: (value) => selectedIndex = value,
                  // useMagnifier: true,
                  // children: years.map((e) {
                  //   return Container(
                  //     alignment: Alignment.center,
                  //     child: AppText(
                  //       title: e.toString(),
                  //       fontSize: 24,
                  //       fontWeight: FontWeight.w600,
                  //     ),
                  //   );
                  // }).toList(),
                ),
              ),
              AppButton(
                title: 'save'.tr(),
                onTap: () => Navigator.pop(context, selectedDate),
              ),
              SizedBox(height: 16),
            ],
          );
        },
      ),
    );
  }
}
