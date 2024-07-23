import 'package:flutter/material.dart';

class ThemeSet {
  final Brightness brightness;
  final Color primaryColor;
  final Color secondaryColor;
  final Color backgroundColor;
  final Color foregroundColor;
  final Color errorColor;

  ThemeSet({
    required this.brightness,
    required this.primaryColor,
    required this.secondaryColor,
    required this.backgroundColor,
    required this.foregroundColor,
    this.errorColor = Colors.red,
  });

  ThemeData createThemeData() {
    return ThemeData(
      brightness: brightness,
      primarySwatch: createMaterialColor(primaryColor),
      primaryColor: primaryColor,
      scaffoldBackgroundColor: backgroundColor,
      fontFamily: 'RobotoSerif',
      textTheme: createTextTheme(),
      // Button Theme
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryColor,
          foregroundColor: Colors.white,
          disabledBackgroundColor: Colors.grey,
          disabledForegroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: primaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          side: BorderSide(color: primaryColor),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: primaryColor,
        ),
      ),
      // Input Decoration Theme
      inputDecorationTheme: const InputDecorationTheme(
        hintStyle: TextStyle(color: Colors.grey),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(const Radius.circular(10)),
        ),
      ),
      // Checkbox Theme
      checkboxTheme: CheckboxThemeData(
        fillColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return primaryColor;
          }
          return Colors.transparent;
        }),
        checkColor: WidgetStateProperty.all(Colors.white),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      ),
      // Progress Bar Theme
      progressIndicatorTheme: ProgressIndicatorThemeData(
        color: primaryColor,
        linearTrackColor: primaryColor.withOpacity(0.3),
      ),
      // AppBar Theme
      appBarTheme: AppBarTheme(
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
        titleTextStyle: const TextStyle(
            color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      // FloatingActionButton Theme
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: primaryColor,
        foregroundColor: foregroundColor,
      ),
      // BottomNavigationBar Theme
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: primaryColor,
        selectedItemColor: secondaryColor,
        unselectedItemColor: foregroundColor.withOpacity(0.7),
      ),
      useMaterial3: true,
    );
  }

  TextTheme createTextTheme() {
    return TextTheme(
      displayLarge: TextStyle(
          fontSize: 96,
          fontWeight: FontWeight.w300,
          letterSpacing: -1.5,
          color: foregroundColor),
      displayMedium: TextStyle(
          fontSize: 60,
          fontWeight: FontWeight.w300,
          letterSpacing: -0.5,
          color: foregroundColor),
      displaySmall: TextStyle(
          fontSize: 48,
          fontWeight: FontWeight.normal,
          letterSpacing: 0.0,
          color: foregroundColor),
      headlineLarge: TextStyle(
          fontSize: 34,
          fontWeight: FontWeight.normal,
          letterSpacing: 0.25,
          color: foregroundColor),
      headlineMedium: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.normal,
          letterSpacing: 0.0,
          color: foregroundColor),
      titleLarge: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w500,
          letterSpacing: 0.15,
          color: foregroundColor),
      titleMedium: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.normal,
          letterSpacing: 0.15,
          color: foregroundColor),
      titleSmall: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          letterSpacing: 0.1,
          color: foregroundColor),
      bodyLarge: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.normal,
          letterSpacing: 0.5,
          color: foregroundColor),
      bodyMedium: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.normal,
          letterSpacing: 0.25,
          color: foregroundColor),
      bodySmall: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.normal,
          letterSpacing: 0.4,
          color: foregroundColor),
      labelLarge: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          letterSpacing: 1.25,
          color: foregroundColor),
      labelMedium: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.normal,
          letterSpacing: 1.5,
          color: foregroundColor),
      labelSmall: TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.normal,
          letterSpacing: 1.5,
          color: foregroundColor),
    );
  }

  MaterialColor createMaterialColor(Color color) {
    List strengths = <double>[.05];
    Map<int, Color> swatch = {};
    final int r = color.red, g = color.green, b = color.blue;

    for (int i = 1; i < 10; i++) {
      strengths.add(0.1 * i);
    }
    for (var strength in strengths) {
      final double ds = 0.5 - strength;
      swatch[(strength * 1000).round()] = Color.fromRGBO(
        r + ((ds < 0 ? r : (255 - r)) * ds).round(),
        g + ((ds < 0 ? g : (255 - g)) * ds).round(),
        b + ((ds < 0 ? b : (255 - b)) * ds).round(),
        1,
      );
    }
    return MaterialColor(color.value, swatch);
  }
}

final ThemeSet lightThemeSet = ThemeSet(
  brightness: Brightness.light,
  primaryColor: Colors.deepPurple,
  secondaryColor: Colors.amber,
  backgroundColor: Colors.white,
  foregroundColor: Colors.black,
);

final ThemeSet darkThemeSet = ThemeSet(
  brightness: Brightness.dark,
  primaryColor: const Color.fromARGB(255, 2, 121, 22),
  secondaryColor: const Color.fromARGB(255, 217, 232, 239),
  backgroundColor: Colors.black,
  foregroundColor: Colors.white,
);
