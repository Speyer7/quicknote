import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quicknote/core/data/shared_prefs.dart';
import 'package:quicknote/core/providers/is_dark_mode_provider.dart';
import 'package:quicknote/core/providers/text_size_provider.dart';
import 'package:quicknote/core/utils/get_font_size_from_level.dart';
import 'package:quicknote/core/widgets/colorTheme_widget.dart';
import 'package:quicknote/core/widgets/textSize_widget.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    
    final isDarkMode = ref.watch(isDarkModeProvider);
    final level = ref.watch(textSizeProvider);
    final fontSizeValue = getFontSizeFromLevel(level, "big");

    return Column(
      children: [
        SizedBox(height: 20.0,),
        Text('Settings', style: TextStyle(fontSize: fontSizeValue)),
        DarkModeSetting(isDarkMode: isDarkMode),
        TextSizeSelector(),
        ColorthemeWidget(),
      ],
    );
  }
}

class DarkModeSetting extends ConsumerWidget {
  const DarkModeSetting({
    super.key,
    required this.isDarkMode,
  });

  final bool isDarkMode;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    
    final isDarkMode = ref.watch(isDarkModeProvider);
    final level = ref.watch(textSizeProvider);
    final fontSizeValue = getFontSizeFromLevel(level, "normal");

    return SwitchListTile(
      value: isDarkMode,
      title: Text("Dark Mode", style: TextStyle(fontSize: fontSizeValue),),
      onChanged: (value) {
        ref.read(isDarkModeProvider.notifier).state =
            value;
        SharedPrefs.setDarkMode(value);
      },
    );
  }
}
