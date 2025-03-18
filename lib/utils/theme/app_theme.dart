import 'package:flutter/material.dart';
import 'package:vizzano_report_tv/utils/theme/app_colors.dart';

class AppTheme {
  static ThemeData get lightTheme => ThemeData(
        fontFamily: "Montserrat",
        scaffoldBackgroundColor: AppColors.secondary,
        primaryColor: AppColors.primary,
        textTheme: TextTheme(
          titleLarge: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w700,
          ),
          titleMedium: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w700,
          ),
          titleSmall: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w700,
          ),
          bodyLarge: TextStyle(
            fontSize: 24,
          ),
          bodyMedium: TextStyle(
            fontSize: 20,
          ),
          bodySmall: TextStyle(
            fontSize: 16,
          ),
        ),
      );
}
