import 'package:base_project/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ThemeState {
  final ThemeData themeData;
  final bool isDarkMode;

  ThemeState({
    required this.themeData,
    required this.isDarkMode,
  });
}

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit()
      : super(
          ThemeState(
            themeData: buildAppTheme(),
            isDarkMode: false,
          ),
        );

  void toggleTheme() {
    final isDark = !state.isDarkMode;
    emit(
      ThemeState(
        themeData: isDark ? buildDarkTheme() : buildAppTheme(),
        isDarkMode: isDark,
      ),
    );
  }
}
