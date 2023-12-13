import 'package:flutter/material.dart';
import 'package:mavie/src/personal_virtual/personal_virtual_view.dart';
import 'package:mavie/src/psicologo_virtual/psicologo_virtual_view.dart';

import '../settings/settings_view.dart';
import 'feature.dart';

/// Displays a list of SampleItems.
class FeatureListView extends StatelessWidget {
  const FeatureListView({
    super.key,
    this.items = const [
      Feature(1, 'Psicólogo Virtual', PsicologoVirtualView.routeName,
          'assets/images/psicologia.webp'),
      Feature(2, 'Personal Virtual', PersonalVirtualView.routeName,
          'assets/images/personal-trainer.webp'),
    ],
  });

  static const routeName = '/';

  final List<Feature> items;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Funcionalidades'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              // Navigate to the settings page. If the user leaves and returns
              // to the app after it has been killed while running in the
              // background, the navigation stack is restored.
              Navigator.restorablePushNamed(context, SettingsView.routeName);
            },
          ),
        ],
      ),

      // To work with lists that may contain a large number of items, it’s best
      // to use the ListView.builder constructor.
      //
      // In contrast to the default ListView constructor, which requires
      // building all Widgets up front, the ListView.builder constructor lazily
      // builds Widgets as they’re scrolled into view.
      body: ListView.builder(
        // Providing a restorationId allows the ListView to restore the
        // scroll position when a user leaves and returns to the app after it
        // has been killed while running in the background.
        restorationId: 'sampleItemListView',
        itemCount: items.length,
        itemBuilder: (BuildContext context, int index) {
          final item = items[index];

          return ListTile(
              title: Text(item.name),
              leading: CircleAvatar(
                // Display the Flutter Logo image asset.
                foregroundImage: AssetImage(item.imageUri),
              ),
              onTap: () {
                // Navigate to the details page. If the user leaves and returns to
                // the app after it has been killed while running in the
                // background, the navigation stack is restored.
                Navigator.restorablePushNamed(
                  context,
                  item.routeName,
                );
              });
        },
      ),
    );
  }
}
