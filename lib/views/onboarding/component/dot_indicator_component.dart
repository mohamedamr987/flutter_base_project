import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:base_project/core/theme/app_colors.dart';
import 'package:base_project/views/onboarding/cubit.dart';

class DotIndicatorComponent extends StatelessWidget {
  const DotIndicatorComponent({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = OnboardingCubit.of(context);
    return BlocBuilder(
      bloc: cubit,
      builder: (context, state) {
        return DotsIndicator(
          dotsCount: 4,
          position: (cubit.pageController.page?.round() ?? 0).toDouble(),
          decorator: DotsDecorator(
            spacing: const EdgeInsets.symmetric(horizontal: 2),
            size: const Size.square(6.0),
            activeSize: const Size(32.0, 6.0),
            activeShape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(500),
            ),
            activeColor: AppColors.primary,
          ),
        );
      },
    );
  }
}
