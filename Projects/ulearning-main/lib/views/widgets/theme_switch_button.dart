import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/index.dart';
import '../../utils/index.dart';

class ThemeSwitch extends StatelessWidget {
  const ThemeSwitch({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ThemeBloc, ThemeState>(
      listener: (context, state) {
        successToast('Theme changed to ${state.themeName}');
      },
      builder: (context, state) {
        return IconButton(
          icon: Icon(
            state.themeMode == ThemeMode.light
                ? Icons.brightness_4
                : Icons.brightness_7,
          ),
          onPressed: () {
            context.read<ThemeBloc>().add(
                  state is ThemeLight
                      ? ThemeDarkEvent()
                      : state is ThemeDark
                          ? ThemeLightEvent()
                          : ThemeSystemEvent(),
                );
          },
        );
      },
    );
  }
}
