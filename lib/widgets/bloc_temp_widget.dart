import 'package:base_project/l10n/localization_keys.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:base_project/core/theme/app_colors.dart';
import 'package:base_project/core/models/response.dart';
import 'package:base_project/widgets/app_text.dart';

class BlocTempWidget extends StatelessWidget {
  final Widget successWidget;
  final ResponseModel responseModel;
  final String? emptyTitle;
  final Widget? emptyWidget;
  final bool? isEmpty;

  const BlocTempWidget({
    Key? key,
    required this.successWidget,
    required this.responseModel,
    this.emptyTitle,
    this.emptyWidget,
    this.isEmpty,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: responseModel.when(
        initial: () => Center(
          child: LoadingAnimationWidget.inkDrop(
            color: AppColors.primary,
            size: 60,
          ),
        ),
        loading: () => Center(
          child: LoadingAnimationWidget.inkDrop(
            color: AppColors.primary,
            size: 60,
          ),
        ),
        paginationLoading: (data) => successWidget,
        loaded: (data) {
          if ((data is List && data.isEmpty && (isEmpty == null || isEmpty!)) ||
              (isEmpty != null && isEmpty!)) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                // Image.asset(
                //   Utils.getAssetPNGPath("no_content_backup"),
                //   width: 280,
                // ),
                // const SizedBox(height: 20),
                AppText(
                  title: emptyTitle ?? LocalizationKeys.noDataAvailable.tr(),
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  textAlign: TextAlign.center,
                ),
                if (emptyWidget != null) ...[
                  const SizedBox(height: 20),
                  emptyWidget!
                ],
              ],
            );
          } else {
            return successWidget;
          }
        },
        error: (e) => Center(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: AppText(
              title: LocalizationKeys.somethingWentWrong.tr(),
              fontSize: 20,
              fontWeight: FontWeight.w600,
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}
