import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quicknote/core/providers/selected_page_provider.dart';
import 'package:quicknote/core/screens/notes_screen.dart';
import 'package:quicknote/core/screens/settings_screen.dart';

Widget getCurrentPage(WidgetRef ref) {
  final selectedIndex = ref.watch(selectedPageProvider);

  switch (selectedIndex) {
    case 0:
      return NotesScreen();
    case 1:
      return SettingsScreen();
    default:
      return Text("Invalid selectedIndex");
  }

}