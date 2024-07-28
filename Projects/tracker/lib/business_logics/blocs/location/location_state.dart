part of 'location_bloc.dart';

class LocationState extends Equatable {
  final LocationStatus status;
  final List<LocationModel> locations;
  final bool isListening;

  const LocationState({
    this.status = LocationStatus.initial,
    this.locations = const [],
    this.isListening = false,
  });

  LocationState copyWith({
    LocationStatus? status,
    List<LocationModel>? locations,
    bool? isListening,
  }) {
    return LocationState(
      status: status ?? this.status,
      locations: locations ?? this.locations,
      isListening: isListening ?? this.isListening,
    );
  }

  @override
  List<Object> get props => [
        status,
        locations,
        isListening,
      ];
}
