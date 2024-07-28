import 'package:ext_plus/ext_plus.dart';
import 'package:tracker/business_logics/blocs/index.dart';

class MyBlocObserver extends BlocObserver {
  @override
  void onCreate(BlocBase bloc) {
    super.onCreate(bloc);
    printF('Bloc ${bloc.runtimeType} created');
    if (bloc is LocationBloc) {
      1.delay.then((value) => bloc.add(ListenLocationsEvent()));
      1.delay.then((value) => bloc.add(AutoAddLocationEvent()));
    }
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    super.onError(bloc, error, stackTrace);
    loggError('Bloc ${bloc.runtimeType} error: $error');
  }
}
