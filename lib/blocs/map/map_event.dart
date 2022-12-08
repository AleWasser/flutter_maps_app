part of 'map_bloc.dart';

abstract class MapEvent extends Equatable {
  const MapEvent();

  @override
  List<Object> get props => [];
}

class OnMapInitializedEvent extends MapEvent {
  final GoogleMapController controller;
  const OnMapInitializedEvent(this.controller);
}

class OnToggleFollowingUserEvent extends MapEvent {
  final bool isFollowingUser;

  const OnToggleFollowingUserEvent(this.isFollowingUser);
}

class OnUpdatePolylinesEvent extends MapEvent {
  final List<LatLng> history;

  const OnUpdatePolylinesEvent(this.history);
}

class OnToggleUserRouteEvent extends MapEvent {}

class OnPolylineEvent extends MapEvent {
  final Map<String, Polyline> polylines;

  const OnPolylineEvent(this.polylines);
}
