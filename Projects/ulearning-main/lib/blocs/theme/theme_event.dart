part of 'theme_bloc.dart';

@immutable
sealed class ThemeEvent {}

final class ThemeSystemEvent extends ThemeEvent {}

final class ThemeLightEvent extends ThemeEvent {}

final class ThemeDarkEvent extends ThemeEvent {}
