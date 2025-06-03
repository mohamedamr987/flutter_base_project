import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:base_project/views/onboarding/cubit.dart';
import 'package:base_project/widgets/app_button.dart';

class ButtonsComponent extends StatelessWidget {
  const ButtonsComponent({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = OnboardingCubit.of(context);
    return BlocBuilder(
      bloc: cubit,
      builder: (context, state) {
        return AppButton(
          title: cubit.pageController.page?.round() == 3
              ? "get_started".tr()
              : "next".tr(),
          onTap: cubit.pageController.page?.round() == 3
              ? () {
                  // RouteUtils.navigateAndPopAll(const LoginView());
                }
              : cubit.nextPage,
        );
      },
    );
  }
}
