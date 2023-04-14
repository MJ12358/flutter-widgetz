import 'package:flutter/material.dart';
import 'package:flutter_widgetz/flutter_widgetz.dart';

class SearchBarPage extends StatelessWidget {
  const SearchBarPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomSingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: SpacedColumn(
        children: <Widget>[
          const SearchBar(
            onChanged: print,
          ),
          SearchBar(
            onChanged: print,
            onClear: () {},
          ),
        ],
      ),
    );
  }
}
