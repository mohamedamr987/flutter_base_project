import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:base_project/core/routing/app_router.dart';

import 'package:base_project/widgets/app_button.dart';
import 'package:base_project/widgets/app_text.dart';

import '../core/helpers/utils.dart';

class AppTimeRangePicker extends StatefulWidget {
  const AppTimeRangePicker({Key? key}) : super(key: key);

  static Future<Map<String, TimeOfDay>?> show() async {
    final result = await showModalBottomSheet(
      context: navigatorKey.currentContext!,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return AppTimeRangePicker();
      },
    );
    return result;
  }

  @override
  State<AppTimeRangePicker> createState() => _AppTimeRangePickerState();
}

class _AppTimeRangePickerState extends State<AppTimeRangePicker> {
  final initialTime = DateTime(0, 0, 0, 0, 0);

  TimeOfDay from = TimeOfDay(hour: 0, minute: 0);
  TimeOfDay to = TimeOfDay(hour: 0, minute: 0);

  @override
  Widget build(BuildContext context) {
    return BottomSheet(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
      ),
      onClosing: () {},
      builder: (context) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Localizations(
              delegates: context.localizationDelegates,
              locale: Locale('en'),
              child: Column(
                crossAxisAlignment: Utils.isAR
                    ? CrossAxisAlignment.end
                    : CrossAxisAlignment.start,
                children: [
                  AppText(
                    title: 'from'.tr(),
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                  ),
                  Expanded(
                    child: CupertinoDatePicker(
                      initialDateTime: initialTime,
                      mode: CupertinoDatePickerMode.time,
                      use24hFormat: true,
                      onDateTimeChanged: (DateTime value) {
                        from = TimeOfDay.fromDateTime(value);
                      },
                    ),
                  ),
                  AppText(
                    title: 'to'.tr(),
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                  ),
                  Expanded(
                    child: CupertinoDatePicker(
                      initialDateTime: initialTime,
                      mode: CupertinoDatePickerMode.time,
                      use24hFormat: true,
                      onDateTimeChanged: (DateTime value) {
                        to = TimeOfDay.fromDateTime(value);
                      },
                    ),
                  ),
                  Center(
                    child: AppButton(
                      title: 'save'.tr(),
                      onTap: () {
                        Navigator.pop(
                          context,
                          {
                            'from': from,
                            'to': to,
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
