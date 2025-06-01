import 'package:base_project/core/theme/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:base_project/core/helpers/dimensions.dart';

class AppSwitch extends StatelessWidget {
  const AppSwitch({
    super.key,
    required this.value,
    this.onChanged,
    this.rotate = true,
    this.color = AppColors.primary,
  });

  final bool value;
  final void Function(bool)? onChanged;
  final bool rotate;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 32.width,
      height: 24.height,
      child: Transform.scale(
        transformHitTests: false,
        scale: 0.5,
        child: RotatedBox(
          quarterTurns: rotate ? 2 : 0,
          child: CupertinoSwitch(
            value: value,
            onChanged: onChanged,
            activeTrackColor: color,
          ),
        ),
      ),
    );
  }
}
