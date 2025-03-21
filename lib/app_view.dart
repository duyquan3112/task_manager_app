import 'package:flutter/material.dart';

import 'common/colors.dart';
import 'features/task_manager/page/task_manager_page.dart';

class AppView extends StatelessWidget {
  const AppView({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: UIColors.instance.primaryColor,
        ),
        appBarTheme: AppBarTheme(
          scrolledUnderElevation: 0.0,
          foregroundColor: UIColors.instance.defaultColor,
        ),
        scaffoldBackgroundColor: UIColors.instance.backgroundColor,
        useMaterial3: true,
        textTheme: TextTheme(
          bodyLarge: TextStyle(color: UIColors.instance.defaultColor),
          bodyMedium: TextStyle(color: UIColors.instance.defaultColor),
          bodySmall: TextStyle(color: UIColors.instance.defaultColor),
          titleLarge: TextStyle(color: UIColors.instance.defaultColor),
          titleMedium: TextStyle(color: UIColors.instance.defaultColor),
          titleSmall: TextStyle(color: UIColors.instance.defaultColor),
          headlineLarge: TextStyle(color: UIColors.instance.defaultColor),
          headlineMedium: TextStyle(color: UIColors.instance.defaultColor),
          headlineSmall: TextStyle(color: UIColors.instance.defaultColor),
          labelLarge: TextStyle(color: UIColors.instance.defaultColor),
          labelMedium: TextStyle(color: UIColors.instance.defaultColor),
          labelSmall: TextStyle(color: UIColors.instance.defaultColor),
          displayLarge: TextStyle(color: UIColors.instance.defaultColor),
          displayMedium: TextStyle(color: UIColors.instance.defaultColor),
          displaySmall: TextStyle(color: UIColors.instance.defaultColor),
        )..apply(),
        inputDecorationTheme: InputDecorationTheme(
          hintStyle: TextStyle(color: UIColors.instance.defaultColor),
          labelStyle: TextStyle(color: UIColors.instance.defaultColor),
        ),
        dividerTheme: DividerThemeData(
          thickness: 1,
          color: UIColors.instance.backgroundColor,
        ),
        progressIndicatorTheme: ProgressIndicatorThemeData(
          color: UIColors.instance.primaryColor,
          linearTrackColor: UIColors.instance.lightBlueColor,
          circularTrackColor: Colors.transparent,
        ),
      ),
      home: const TaskManagerPage(),
    );
  }
}
