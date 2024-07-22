part of 'theme_bloc.dart';

@immutable
abstract class ThemeState {
  ThemeMode get themeMode => ThemeMode.light;
}

class ThemeSystem extends ThemeState {}

class ThemeLight implements ThemeState {
  @override
  ThemeMode get themeMode => ThemeMode.light;
}

class ThemeDark implements ThemeState {
  @override
  ThemeMode get themeMode => ThemeMode.dark;
}
