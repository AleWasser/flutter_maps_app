import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:maps_app/blocs/blocs.dart';
import 'package:maps_app/screens/screens.dart';

void main() {
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (BuildContext _) => GpsBloc()),
        BlocProvider(create: (BuildContext _) => LocationBloc()),
        BlocProvider(
          create: (BuildContext context) => MapBloc(
            locationBloc: BlocProvider.of<LocationBloc>(context),
          ),
        ),
      ],
      child: const MapsApp(),
    ),
  );
}

class MapsApp extends StatelessWidget {
  const MapsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Maps App',
      home: LoadingScreen(),
    );
  }
}
