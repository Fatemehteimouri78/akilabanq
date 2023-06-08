import 'package:akilabanq/presentation/pages/wallet/model/token_model.dart';
import 'package:flutter/material.dart';

class CustomSearchDelegate extends SearchDelegate {
  CustomSearchDelegate({required this.tokens});

  final List<TokenModel> tokens;

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query = '';
          },
          icon: const Icon(Icons.delete))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          close(context, null);
        },
        icon: const Icon(Icons.close));
  }

  @override
  Widget buildResults(BuildContext context) {
    List<String> machQuery = [];
    for (var token in tokens) {
      if (token.name.toLowerCase().contains(query.toLowerCase())) {
        machQuery.add(token.name);
      }
    }
    return ListView.builder(
        itemCount: machQuery.length,
        itemBuilder: (context, index) {
          var result = machQuery[index];
          return ListTile(
            title: Text(result),
          );
        });
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<String> machQuery = [];
    for (var token in tokens) {
      if (token.name.toLowerCase().contains(query.toLowerCase())) {
        machQuery.add(token.name);
      }
    }
    return ListView.builder(
        itemCount: machQuery.length,
        itemBuilder: (context, index) {
          var result = machQuery[index];
          return ListTile(
            title: Text(
              result,
              textDirection: TextDirection.ltr,
            ),
          );
        });
  }
}
