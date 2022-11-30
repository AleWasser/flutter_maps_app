part of 'location_bloc.dart';

class LocationState extends Equatable {
  final bool followingUser;
  final LatLng? lastKnowLocation;
  final List<LatLng> myLocationStory;

  const LocationState(
      {this.followingUser = false, this.lastKnowLocation, myLocationStory})
      : myLocationStory = myLocationStory ?? const [];

  LocationState copyWith({
    bool? followingUser,
    LatLng? lastKnowLocation,
    List<LatLng>? myLocationStory,
  }) =>
      LocationState(
        followingUser: followingUser ?? this.followingUser,
        lastKnowLocation: lastKnowLocation ?? this.lastKnowLocation,
        myLocationStory: myLocationStory ?? this.myLocationStory,
      );

  @override
  List<Object?> get props => [followingUser, lastKnowLocation, myLocationStory];
}
