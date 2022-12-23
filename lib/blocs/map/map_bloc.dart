import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:maps_app/helpers/helpers.dart';

import 'package:maps_app/themes/themes.dart';
import '../../models/models.dart';
import '../blocs.dart';

part 'map_event.dart';
part 'map_state.dart';

class MapBloc extends Bloc<MapEvent, MapState> {
  final LocationBloc locationBloc;
  StreamSubscription<LocationState>? locationStateSubscription;
  GoogleMapController? _mapController;
  LatLng? mapCenter;

  MapBloc({required this.locationBloc}) : super(const MapState()) {
    on<OnMapInitializedEvent>(_onInitMap);
    on<OnToggleFollowingUserEvent>(_onToggleFollowingUser);
    on<OnUpdatePolylinesEvent>(_onUpdatePolylines);
    on<OnToggleUserRouteEvent>(
      (event, emit) => emit(
        state.copyWith(
          showMyRoute: !state.showMyRoute,
        ),
      ),
    );
    on<OnPolylineEvent>(
      (event, emit) => emit(
        state.copyWith(
          polylines: event.polylines,
          markers: event.markers,
        ),
      ),
    );

    locationStateSubscription = locationBloc.stream.listen((locationState) {
      if (locationState.lastKnowLocation == null) return;
      add(OnUpdatePolylinesEvent(locationState.myLocationStory));

      if (!state.isFollowingUser) return;
      moveCamera(locationState.lastKnowLocation!);
    });
  }

  void _onInitMap(OnMapInitializedEvent event, Emitter<MapState> emit) {
    _mapController = event.controller;
    _mapController!.setMapStyle(jsonEncode(retroTheme));

    emit(state.copyWith(isInitialized: true));
  }

  void _onToggleFollowingUser(
      OnToggleFollowingUserEvent event, Emitter<MapState> emit) {
    if (state.isFollowingUser == event.isFollowingUser) return;

    emit(state.copyWith(isFollowingUser: event.isFollowingUser));

    if (state.isFollowingUser && locationBloc.state.lastKnowLocation != null) {
      moveCamera(locationBloc.state.lastKnowLocation!);
    }
  }

  void _onUpdatePolylines(
    OnUpdatePolylinesEvent event,
    Emitter<MapState> emit,
  ) {
    final myRoute = Polyline(
      polylineId: const PolylineId('myRoute'),
      color: Colors.teal,
      width: 5,
      startCap: Cap.roundCap,
      endCap: Cap.roundCap,
      points: event.history,
    );
    final currentPolylines = Map<String, Polyline>.from(state.polylines);
    currentPolylines['myRoute'] = myRoute;

    emit(state.copyWith(polylines: currentPolylines));
  }

  Future<void> drawPolyline(RouteDestinationModel destination) async {
    final route = Polyline(
      polylineId: const PolylineId('route'),
      color: Colors.pink,
      width: 5,
      startCap: Cap.roundCap,
      endCap: Cap.roundCap,
      points: destination.points,
    );
    final currentPolylines = Map<String, Polyline>.from(state.polylines);
    currentPolylines['route'] = route;

    double kilometers = destination.distance / 1000;
    kilometers = (kilometers * 100).floorToDouble();
    kilometers /= 100;

    int tripLength = (destination.duration / 60).floorToDouble().toInt();

    final startMarkerImage = await getStartCustomMarker(
      tripLength,
      'Current Location',
    );
    final endMarkerImage = await getEndCustomMarker(
      kilometers.toInt(),
      destination.destinationPlace.text,
    );

    final startMarker = Marker(
      anchor: const Offset(0.5, 1),
      markerId: const MarkerId('start'),
      position: destination.points.first,
      icon: startMarkerImage,
    );
    final endMarker = Marker(
      markerId: const MarkerId('end'),
      position: destination.points.last,
      icon: endMarkerImage,
    );

    final currentMarkers = Map<String, Marker>.from(state.markers);
    currentMarkers['start'] = startMarker;
    currentMarkers['end'] = endMarker;

    add(OnPolylineEvent(currentPolylines, currentMarkers));
  }

  void moveCamera(LatLng newLocation) {
    final cameraUpdate = CameraUpdate.newLatLng(newLocation);
    _mapController?.animateCamera(cameraUpdate);
  }

  @override
  Future<void> close() {
    locationStateSubscription?.cancel();
    return super.close();
  }
}
