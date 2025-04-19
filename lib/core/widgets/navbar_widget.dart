import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quicknote/core/providers/selected_page_provider.dart';


class NavbarWidget extends ConsumerWidget {
  const NavbarWidget({super.key, });

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final selectedIndex = ref.watch(
      selectedPageProvider,
    );

    return NavigationBar(
      destinations: [
        NavigationDestination(
          icon: Icon(Icons.notes),
          label: 'Notes',
        ),
        NavigationDestination(
          icon: Icon(Icons.settings),
          label: 'Settings',
        ),
      ],
      onDestinationSelected: (value) {
        ref.read(selectedPageProvider.notifier).state = value;
      },
      selectedIndex: selectedIndex,
    );
  }
}
