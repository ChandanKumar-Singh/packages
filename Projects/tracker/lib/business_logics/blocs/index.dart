import 'package:flutter_bloc/flutter_bloc.dart';

import 'index.dart';

export 'auth/auth_bloc.dart';
export 'location/location_bloc.dart';

export 'theme/theme_bloc.dart';

class Blocs {
  static List<BlocProvider> get blocs => [
        BlocProvider<ThemeBloc>(create: (context) => ThemeBloc()),
        BlocProvider<AuthBloc>(create: (context) => AuthBloc()),
      ];
}
