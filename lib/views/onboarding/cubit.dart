import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'states.dart';

class OnboardingCubit extends Cubit<OnboardingStates> {
  OnboardingCubit() : super(OnboardingInit()) {
    pageController.addListener(listener);
  }
  static OnboardingCubit of(context) => BlocProvider.of(context);
  PageController pageController = PageController();

  void listener() {
    emit(OnboardingInit());
  }

  void nextPage() {
    pageController.nextPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  bool get isStateLoading {
    return state is OnboardingLoading;
  }

  void _emit(OnboardingStates state) {
    if (!isClosed) {
      emit(state);
    }
  }

  @override
  Future<void> close() {
    pageController.removeListener(listener);
    return super.close();
  }
}
