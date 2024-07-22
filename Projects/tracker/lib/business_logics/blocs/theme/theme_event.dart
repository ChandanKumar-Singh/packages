part of 'theme_bloc.dart';

@immutable
sealed class ThemeEvent {}

class ThemeSystemEvent extends ThemeEvent {}

class ThemeLightEvent extends ThemeEvent {
  static ThemeMode themeMode = ThemeMode.light;
}

class ThemeDarkEvent extends ThemeEvent {
  static ThemeMode themeMode = ThemeMode.dark;
}
