import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quicknote/core/data/shared_prefs.dart';
import 'package:quicknote/core/providers/color_theme_provider.dart';
import 'package:quicknote/core/providers/text_size_provider.dart';
import 'package:quicknote/core/utils/get_color_theme.dart';
import 'package:quicknote/core/utils/get_font_size_from_level.dart';

class ColorthemeWidget extends ConsumerWidget {
  const ColorthemeWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final level = ref.watch(textSizeProvider);
    final fontSizeValue = getFontSizeFromLevel(level, "normal");

    final colortheme_level = ref.watch(colorThemeProvider);
    final colorthemeValue = getColorTheme(colortheme_level);

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text('Color Theme', style: TextStyle(fontSize: fontSizeValue)),
        Slider.adaptive(
          value: colortheme_level.toDouble(),
          activeColor: colorthemeValue,
          min: 0,
          max: 4,
          divisions: 4,
          onChanged: (value) {
            ref.read(colorThemeProvider.notifier).state = value.toInt();
            SharedPrefs.setColorTheme(value.toInt());
          },
        ),
      ],
    );
  }
}
