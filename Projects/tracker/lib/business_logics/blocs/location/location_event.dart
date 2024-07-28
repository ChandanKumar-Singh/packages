part of 'location_bloc.dart';

@immutable
sealed class LocationEvent {}

class AddLocationEvent extends LocationEvent {}

class ListenLocationsEvent extends LocationEvent {}

class StopListenLocationsEvent extends LocationEvent {}

class AutoAddLocationEvent extends LocationEvent {}
