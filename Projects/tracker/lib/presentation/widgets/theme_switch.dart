import 'package:flutter/material.dart';
import '/business_logics/blocs/index.dart';

class ThemeSwitch extends StatelessWidget {
  const ThemeSwitch({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ThemeBloc, ThemeState>(
      listener: (context, state) {},
      builder: (context, state) {
        return IconButton(
          onPressed: () {
            context.read<ThemeBloc>().add(
                state is ThemeLight ? ThemeDarkEvent() : ThemeLightEvent());
          },
          icon: const Icon(
            Icons.brightness_4,
            color: Colors.red,
          ),
        );
      },
    );
  }
}
