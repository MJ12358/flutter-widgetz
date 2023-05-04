import 'package:flutter/material.dart';
import 'package:flutter_widgetz/flutter_widgetz.dart';

class SearchBarPage extends StatefulWidget {
  const SearchBarPage({Key? key}) : super(key: key);

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
            labelText: 'Search Bar One',
            onChanged: print,
          ),
          SearchBar(
            labelText: 'Search Bar Two (with onClear)',
            onChanged: print,
            onClear: () {},
          ),
          CustomElevatedButton(
            text: 'Toggle Visibility',
            onPressed: () => setState(() {
              _isVisible = !_isVisible;
            }),
          ),
          SearchBar(
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
