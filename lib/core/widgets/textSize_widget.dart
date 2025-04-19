// text_size_selector.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quicknote/core/data/shared_prefs.dart';
import 'package:quicknote/core/providers/text_size_provider.dart';
import 'package:quicknote/core/utils/get_font_size_from_level.dart';

class TextSizeSelector extends ConsumerWidget {
  const TextSizeSelector({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final level = ref.watch(textSizeProvider);
    final fontSizeValue = getFontSizeFromLevel(level, "normal");

    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text("Textgröße", style: TextStyle(fontSize: fontSizeValue),),
          Slider(
            value: level.toDouble(),
            min: 0,
            max: 4,
            divisions: 4,
            onChanged: (value) {
              ref.read(textSizeProvider.notifier).state = value.toInt();
              SharedPrefs.setFontSize(value.toInt());
            },
          ),
        ],
      ),
    );
  }
}
