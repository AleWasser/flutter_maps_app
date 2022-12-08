import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:maps_app/helpers/helpers.dart';
import '../blocs/blocs.dart';

class ManualMarkerWidget extends StatelessWidget {
  const ManualMarkerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchBloc, SearchState>(
      builder: (context, state) {
        return state.displayManualMarker
            ? const _ManualMarkerBody()
            : const SizedBox();
      },
    );
  }
}

class _ManualMarkerBody extends StatelessWidget {
  const _ManualMarkerBody({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final locationBloc = BlocProvider.of<LocationBloc>(context);
    final mapBloc = BlocProvider.of<MapBloc>(context);
    final searchBloc = BlocProvider.of<SearchBloc>(context);

    return SizedBox(
      width: size.width,
      height: size.height,
      child: Stack(
        children: [
          const Positioned(
            top: 70,
            left: 20,
            child: _BtnBack(),
          ),
          Center(
            child: Transform.translate(
              offset: const Offset(0, -22),
              child: BounceInDown(
                from: 100,
                child: const Icon(
                  Icons.location_on_rounded,
                  size: 60,
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 70,
            left: 40,
            child: FadeInUp(
              duration: const Duration(milliseconds: 300),
              child: MaterialButton(
                minWidth: size.width - 120,
                color: Colors.pink,
                elevation: 0,
                height: 50,
                shape: const StadiumBorder(),
                child: const Text(
                  'Confirm Marker',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                onPressed: () async {
                  final start = locationBloc.state.lastKnowLocation;
                  final end = mapBloc.mapCenter;

                  if (start == null) return;
                  if (end == null) return;

                  showLoadingMessage(context);

                  final destination =
                      await searchBloc.getCoordsStartToEnd(start, end);
                  await mapBloc.drawPolyline(destination);

                  searchBloc.add(OnDeactivateManualMarkerEvent());
                  Navigator.pop(context);
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}

class _BtnBack extends StatelessWidget {
  const _BtnBack({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FadeInLeft(
      duration: const Duration(milliseconds: 300),
      child: CircleAvatar(
        maxRadius: 25,
        backgroundColor: Colors.white,
        child: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: Colors.pink,
          ),
          onPressed: () => BlocProvider.of<SearchBloc>(context)
              .add(OnDeactivateManualMarkerEvent()),
        ),
      ),
    );
  }
}
