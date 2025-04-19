import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quicknote/core/data/shared_prefs.dart';
import 'package:quicknote/core/providers/color_theme_provider.dart';
import 'package:quicknote/core/providers/is_dark_mode_provider.dart';
import 'package:quicknote/core/providers/text_size_provider.dart';
import 'package:quicknote/core/utils/get_color_theme.dart';
import 'package:quicknote/widget_tree.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final isDarkMode = await SharedPrefs.getDarkMode();
  final textSize = await SharedPrefs.getFontSize();
  final colorTheme = await SharedPrefs.getColorTheme();
  runApp(
    ProviderScope(
      overrides: [
        isDarkModeProvider.overrideWith(
          (ref) => isDarkMode,
        ),
        textSizeProvider.overrideWith(
          (ref) => textSize,
        ),
        colorThemeProvider.overrideWith(
          (ref) => colorTheme,
        )
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorThemeLevel = ref.watch(colorThemeProvider);
    final seedColor = getColorTheme(colorThemeLevel);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'QuickNote',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: seedColor,
          brightness:
              ref.watch(isDarkModeProvider)
                  ? Brightness.dark
                  : Brightness.light,
        ),
      ),
      home: const WidgetTree(),
    );
  }
}
