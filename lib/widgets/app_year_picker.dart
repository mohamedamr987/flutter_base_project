import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:base_project/core/routing/app_router.dart';

import 'package:base_project/widgets/app_button.dart';
import 'package:base_project/widgets/app_text.dart';

class AppYearPicker extends StatefulWidget {
  const AppYearPicker({Key? key, required this.title}) : super(key: key);

  final String title;

  static Future<int?> show({required String title}) {
    return showModalBottomSheet(
      context: navigatorKey.currentContext!,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
      ),
      builder: (context) {
        return AppYearPicker(
          title: title,
        );
      },
    );
  }

  @override
  State<AppYearPicker> createState() => _AppYearPickerState();
}

class _AppYearPickerState extends State<AppYearPicker> {
  final now = DateTime.now();
  List<int> years = [];
  int selectedIndex = 0;

  @override
  void initState() {
    initYears();
    super.initState();
  }

  void initYears() {
    years = List.generate(100, (index) => now.year - index);
    setState(() {});
  }

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
                child: CupertinoPicker(
                  itemExtent: 50,
                  onSelectedItemChanged: (value) => selectedIndex = value,
                  useMagnifier: true,
                  children: years.map((e) {
                    return Container(
                      alignment: Alignment.center,
                      child: AppText(
                        title: e.toString(),
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                      ),
                    );
                  }).toList(),
                ),
              ),
              AppButton(
                title: 'save'.tr(),
                onTap: () => Navigator.pop(context, years[selectedIndex]),
              ),
              SizedBox(height: 16),
            ],
          );
        },
      ),
    );
  }
}
