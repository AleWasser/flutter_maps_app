import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:maps_app/delegates/delegates.dart';
import 'package:maps_app/models/models.dart';
import 'package:maps_app/blocs/blocs.dart';

class SearchBarWidget extends StatelessWidget {
  const SearchBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchBloc, SearchState>(builder: (context, state) {
      return state.displayManualMarker
          ? const SizedBox()
          : const _SearchBarWidgetBody();
    });
  }
}

class _SearchBarWidgetBody extends StatelessWidget {
  const _SearchBarWidgetBody({super.key});

  Future<void> onSearchResults(
      BuildContext context, SearchResultModel searchResult) async {
    final searchBloc = BlocProvider.of<SearchBloc>(context);
    final locationBloc = BlocProvider.of<LocationBloc>(context);
    final mapBloc = BlocProvider.of<MapBloc>(context);

    if (searchResult.manual) {
      searchBloc.add(OnActivateManualMarkerEvent());
      return;
    }

    if (searchResult.position != null) {
      final destination = await searchBloc.getCoordsStartToEnd(
        locationBloc.state.lastKnowLocation!,
        searchResult.position!,
      );

      await mapBloc.drawPolyline(destination);
    }
  }

  @override
  Widget build(BuildContext context) {
    return FadeInDown(
      duration: const Duration(milliseconds: 300),
      child: SafeArea(
          child: Container(
        margin: const EdgeInsets.only(top: 10),
        padding: const EdgeInsets.symmetric(horizontal: 30),
        width: double.infinity,
        child: GestureDetector(
          onTap: () async {
            final result = await showSearch(
              context: context,
              delegate: SearchDestinationDelegate(),
            );
            if (result == null) return;

            await onSearchResults(context, result);
          },
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 13,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(100),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 5,
                  offset: Offset(0, 5),
                )
              ],
            ),
            child: const Text(
              'Where do you want to go?',
              style: TextStyle(color: Colors.black87),
            ),
          ),
        ),
      )),
    );
  }
}
