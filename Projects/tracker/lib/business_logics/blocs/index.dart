import 'package:flutter_bloc/flutter_bloc.dart';

import 'index.dart';

export 'auth/login_bloc.dart';
export 'location/location_bloc.dart';

export 'theme/theme_bloc.dart';

class Blocs {
  static List<BlocProvider> get blocs => [
        BlocProvider<ThemeBloc>(create: (context) => ThemeBloc()),
        BlocProvider<LoginBloc>(create: (context) => LoginBloc()),
      ];
}
