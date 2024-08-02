import 'package:flutter/material.dart';
import 'package:flutter_widgetz/flutter_widgetz.dart';

class SearchBarPage extends StatefulWidget {
  const SearchBarPage({super.key});

  @override
  State<SearchBarPage> createState() => _SearchBarPageState();
}

class _SearchBarPageState extends State<SearchBarPage> {
  late bool _isVisible;

  @override
  void initState() {
    super.initState();
    _isVisible = true;
  }

  @override
  Widget build(BuildContext context) {
    return CustomSingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: SpacedColumn(
        children: <Widget>[
          const SearchBar(
            hintText: 'Default (for reference)',
          ),
          const CustomSearchBar(
            labelText: 'Search Bar',
            onChanged: print,
          ),
          CustomSearchBar(
            labelText: 'Search Bar (with onClear)',
            onChanged: print,
            onClear: () {},
          ),
          CustomElevatedButton(
            child: const Text('Toggle Visibility'),
            onPressed: () => setState(() {
              _isVisible = !_isVisible;
            }),
          ),
          CustomSearchBar(
            labelText: 'Search Bar Three',
            onChanged: print,
            isVisible: _isVisible,
          ),
          const Text('Some other widgets....'),
        ],
      ),
    );
  }
}
