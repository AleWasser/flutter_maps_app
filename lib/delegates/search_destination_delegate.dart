import 'package:flutter/material.dart';

import 'package:maps_app/models/models.dart';

class SearchDestinationDelegate extends SearchDelegate<SearchResultModel> {
  SearchDestinationDelegate() : super(searchFieldLabel: 'Search something');

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () => query = '',
        icon: const Icon(Icons.clear),
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () => close(context, SearchResultModel(cancel: true)),
      icon: const Icon(Icons.arrow_back_ios),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return const Text('buildResults');
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return ListView(
      children: [
        ListTile(
          leading: const Icon(Icons.location_on_outlined, color: Colors.black),
          title: const Text(
            'Set marker manually',
            style: TextStyle(color: Colors.black),
          ),
          onTap: () {
            close(context, SearchResultModel(cancel: false, manual: true));
          },
        ),
      ],
    );
  }
}
