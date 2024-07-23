part of 'app_bloc.dart';

@immutable
class AppState extends Equatable {
  final int bottomNavIndex;

  const AppState({this.bottomNavIndex = 0});

  @override
  List<Object> get props => [bottomNavIndex];
  AppState copyWith({int? bottomNavIndex}) {
    return AppState(bottomNavIndex: bottomNavIndex ?? this.bottomNavIndex);
  }
}
