import 'package:flutter/material.dart';
import 'package:flutter_widgetz/flutter_widgetz.dart';

class ScaffoldPage extends StatelessWidget {
  const ScaffoldPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomSingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: SpacedColumn(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const Text(
            'Everything here is inside a '
            '"CustomScaffold" via the "MaterialApp".',
          ),
          CustomElevatedButton(
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute<dynamic>(
                builder: (_) => const _TestPage(),
              ),
            ),
            child: const Text('Test Scaffold Page'),
          ),
          CustomElevatedButton(
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute<dynamic>(
                builder: (_) => const _TestBottomSheetListPage(),
              ),
            ),
            child: const Text('Bottom Sheet List Page'),
          ),
          CustomElevatedButton(
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute<dynamic>(
                builder: (_) => const _TestBottomSheetWidgetPage(),
              ),
            ),
            child: const Text('Bottom Sheet Widget Page'),
          ),
        ],
      ),
    );
  }
}

class _TestPage extends StatelessWidget {
  const _TestPage();

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: AppBar(
        title: const Text('Test Scaffold Page'),
      ),
      body: const Center(
        child: Text('Now pop this page!'),
      ),
    );
  }
}

class _TestBottomSheetListPage extends StatelessWidget {
  const _TestBottomSheetListPage();

  List<String> get items => List<String>.generate(
        31,
        (int index) => 'Item $index',
      );

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: AppBar(
        title: const Text('Test Scaffold Page'),
      ),
      bottomSheet: Container(
        height: 60.0,
        color: Colors.blueGrey,
        alignment: Alignment.center,
        child: const Text(
          'This is a bottom sheet',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18.0,
          ),
        ),
      ),
      body: ListView.separated(
        itemCount: items.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            title: Text(items[index]),
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return const Divider();
        },
      ),
    );
  }
}

class _TestBottomSheetWidgetPage extends StatelessWidget {
  const _TestBottomSheetWidgetPage();

  List<String> get items => List<String>.generate(
        31,
        (int index) => 'Field $index',
      );

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: AppBar(
        title: const Text('Test Scaffold Page'),
      ),
      bottomSheet: Container(
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(
              color: Theme.of(context)
                  .colorScheme
                  .onSurface
                  .withValues(alpha: 0.1),
            ),
          ),
        ),
        padding: const EdgeInsets.symmetric(
          vertical: 8.0,
          horizontal: 16.0,
        ),
        child: const SaveButton(),
      ),
      body: CustomSingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: SpacedColumn(
          children: items
              .map(
                (String item) => CustomTextField(
                  labelText: item,
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}
