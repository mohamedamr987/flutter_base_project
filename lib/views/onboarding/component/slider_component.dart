import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:base_project/core/helpers/utils.dart';
import 'package:base_project/core/theme/app_colors.dart';
import 'package:base_project/views/onboarding/cubit.dart';
import 'package:base_project/widgets/app_text.dart';

class SliderComponent extends StatelessWidget {
  const SliderComponent({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = OnboardingCubit.of(context);
    return BlocBuilder(
      bloc: cubit,
      builder: (context, state) {
        return SizedBox(
          height: 485,
          child: PageView.builder(
            itemCount: 4,
            controller: cubit.pageController,
            itemBuilder: (context, index) {
              return Stack(
                children: [
                  Center(
                    child: Image.asset(
                      Utils.getAssetPNGPath("onboarding_${index + 1}"),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: SizedBox(
                      height: 98,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          AppText(
                            title: "on_boarding_title_${index + 1}".tr(),
                            fontWeight: FontWeight.w700,
                            fontSize: 24,
                            color: AppColors.primary,
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 12),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                            ),
                            child: AppText(
                              title:
                                  "on_boarding_description_${index + 1}".tr(),
                              fontSize: 11,
                              color: const Color(0xFF6B7280),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              );
            },
            onPageChanged: (index) {},
          ),
        );
      },
    );
  }
}
