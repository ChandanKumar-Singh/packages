part of 'app_bloc.dart';

sealed class AppEvent extends Equatable {
  const AppEvent();

  @override
  List<Object> get props => [];
}


final class AppInitialEvent extends AppEvent {
  const AppInitialEvent();
}

final class AppChangeBottomNavEvent extends AppEvent {
  final int index;

  const AppChangeBottomNavEvent(this.index);

  @override
  List<Object> get props => [index];
}
