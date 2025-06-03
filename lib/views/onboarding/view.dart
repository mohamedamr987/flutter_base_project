import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:base_project/views/onboarding/cubit.dart';
import 'package:base_project/widgets/app_text.dart';

import 'component/buttons_component.dart';
import 'component/dot_indicator_component.dart';
import 'component/slider_component.dart';

class OnboardingView extends StatelessWidget {
  static const String routeName = 'onboarding';
  static const String routePath = '/onboarding';
  const OnboardingView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => OnboardingCubit(),
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Align(
                  alignment: context.locale.toLanguageTag() == "ar"
                      ? Alignment.topLeft
                      : Alignment.topRight,
                  child: InkWell(
                    onTap: () {
                      // RouteUtils.navigateAndPopAll(const LoginView());
                    },
                    child: AppText(
                      title: "skip".tr(),
                      fontWeight: FontWeight.w700,
                      fontSize: 16,
                    ),
                  ),
                ),
                const SizedBox(height: 40),
                const SliderComponent(),
                const SizedBox(height: 40),
                const DotIndicatorComponent(),
                const SizedBox(height: 40),
                const ButtonsComponent(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
