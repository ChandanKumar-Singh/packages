import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'theme_event.dart';
part 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc() : super(ThemeSystem()) {
    on<ThemeSystemEvent>((event, emit) {
      emit(ThemeSystem());
    });

    on<ThemeLightEvent>((event, emit) {
      emit(ThemeLight());
    });

    on<ThemeDarkEvent>((event, emit) {
      emit(ThemeDark());
    });
  }
}
