import 'package:flutter/material.dart';
import 'package:mavie/src/colors.dart';
import 'package:mavie/src/personal_virtual/personal_virtual_view.dart';
import 'package:mavie/src/profile/profile_widget.dart';
import 'package:mavie/src/psicologo_virtual/psicologo_virtual_view.dart';

import '../settings/settings_view.dart';
import 'feature.dart';

/// Displays a list of SampleItems.
class FeatureListView extends StatelessWidget {
  const FeatureListView({
    super.key,
    this.items = const [
      Feature(1, 'Converse com a Mavie', PsicologoVirtualView.routeName,
          'assets/images/mavie-psicologa.png'),
      Feature(2, 'Exercite-se com a Mavie', PersonalVirtualView.routeName,
          'assets/images/mavie-personal.png'),
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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: items
              .map(
                (e) => GestureDetector(
                  onTap: () => {
                    Navigator.restorablePushNamed(
                      context,
                      e.routeName,
                    )
                  },
                  child: ProfileWidget(
                    imageUrl: e.imageUri,
                    name: e.name,
                  ),
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}
