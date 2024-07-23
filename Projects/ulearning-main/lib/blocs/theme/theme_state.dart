part of 'theme_bloc.dart';

@immutable
sealed class ThemeState {
  ThemeMode get themeMode;
  ThemeData get themeData;
  String get themeName;
}

final class ThemeSystem extends ThemeState {
  @override
  ThemeData get themeData => ThemeData();

  @override
  ThemeMode get themeMode => ThemeMode.system;

  @override
  String get themeName => 'System';
}

final class ThemeLight extends ThemeState {
  @override
  ThemeData get themeData => lightThemeSet.createThemeData();

  @override
  ThemeMode get themeMode => ThemeMode.light;

  @override
  String get themeName => 'Light';
}

final class ThemeDark extends ThemeState {
  @override
  ThemeData get themeData => darkThemeSet.createThemeData();

  @override
  ThemeMode get themeMode => ThemeMode.dark;

  @override
  String get themeName => 'Dark';
}

ThemeData themelight() {
  return ThemeData(
    primarySwatch: Colors.deepPurple,
    primaryColor: Colors.deepPurple,
    fontFamily: 'RobotoSerif',
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: Colors.deepPurple,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        side: const BorderSide(color: Colors.deepPurple),
      ),
    ),
    inputDecorationTheme: const InputDecorationTheme(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
    ),
    checkboxTheme: CheckboxThemeData(
      fillColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return Colors.deepPurple;
        }
        return Colors.transparent;
      }),
      checkColor: WidgetStateProperty.all(Colors.white),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
    ),
    useMaterial3: true,
  );
}
