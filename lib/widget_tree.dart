import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quicknote/core/providers/color_theme_provider.dart';
import 'package:quicknote/core/utils/get_color_theme.dart';
import 'package:quicknote/core/utils/get_current_page.dart';
import 'package:quicknote/core/widgets/navbar_widget.dart';

class WidgetTree extends ConsumerWidget {
  const WidgetTree({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorThemeLevel = ref.watch(colorThemeProvider);
    final seedColor = getColorTheme(colorThemeLevel);

    Widget currentPage = getCurrentPage(ref);

    return Scaffold(
      appBar: AppBar(
        title: const Text('QuickNote', style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.w600),),
        centerTitle: true,
        backgroundColor: seedColor,
        elevation: 5.0,
      ),
      body: currentPage,
      bottomNavigationBar: NavbarWidget(),
    );
  }
}
