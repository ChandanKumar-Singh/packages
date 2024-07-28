import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:ext_plus/ext_plus.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:tracker/data/models/index.dart';
import 'package:tracker/data/repositories/index.dart';

import '../../../tests/test_location_repository.dart';

part 'location_event.dart';
part 'location_state.dart';

enum LocationStatus { initial, loading, success, failure }

class LocationBloc extends Bloc<LocationEvent, LocationState> {
  StreamController<List<LocationModel>>? controller;
  LocationBloc() : super(const LocationState()) {
    on<AddLocationEvent>(_addLocation);
    on<ListenLocationsEvent>(_listenLocations);
    on<StopListenLocationsEvent>(_stopListening);
    on<AutoAddLocationEvent>(_autoAddLocation);
  }

  Future<void> _addLocation(
      AddLocationEvent event, Emitter<LocationState> emit) async {
    emit(state.copyWith(status: LocationStatus.loading));
    try {
      await LocationRepository().addLocation();
      emit(state.copyWith(status: LocationStatus.success));
      successToast('Location uploaded successfully 📌',
          alignment: ToastAlignment.bottom);
      emit(state.copyWith(status: LocationStatus.initial));
    } catch (e, st) {
      emit(state.copyWith(status: LocationStatus.failure));
      loggError(e, stackTrace: st);
      errorToast('Failed to add location 📍');
      await 1.delay;
      emit(state.copyWith(status: LocationStatus.initial));
    }
  }

  Future<void> _listenLocations(
      ListenLocationsEvent event, Emitter<LocationState> emit) async {
    controller ??= StreamController<List<LocationModel>>();
    if (controller!.hasListener) return;
    await for (var data in LocationRepository().listenLocations(controller!)) {
      emit(state.copyWith(locations: data));
      printF('_listenLocations ${data.length}', name: runtimeType);
    }
    successToast('Listening to locations 📍', alignment: ToastAlignment.bottom);
  }

  FutureOr<void> _stopListening(
      StopListenLocationsEvent event, Emitter<LocationState> emit) async {
    if (controller == null) return;
    await LocationRepository().stopListenLocations().then((value) {
      controller?.close();
      controller = null;
      successToast('Stopped listening to locations 📍',
          alignment: ToastAlignment.bottom);
    }).onError((error, stackTrace) {
      loggError(error ?? '', stackTrace: stackTrace);
      errorToast('Failed to stop listening to locations 📍');
    });
  }

  Future<void> _autoAddLocation(
      AutoAddLocationEvent event, Emitter<LocationState> emit) async {
    LocationRepository().addLocationChange();
  }

  @override
  Future<void> close() {
    controller?.close();
    return super.close();
  }
}
