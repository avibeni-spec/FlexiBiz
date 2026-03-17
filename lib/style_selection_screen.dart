import 'package:flutter/material.dart';
import 'shape_selection_screen.dart';

class StyleSelectionScreen extends StatelessWidget {
  const StyleSelectionScreen({super.key});

  static const List<String> styles = [
    "טרנדי",
    "קלאסי",
    "יוקרתי",
    "נקי",
    "לאירוע",
    "חתונה",
  ];

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(title: const Text("בחרי סגנון ציפורניים"), centerTitle: true),
        body: ListView.separated(
          padding: const EdgeInsets.all(16),
          itemCount: styles.length,
          separatorBuilder: (_, __) => const SizedBox(height: 8),
          itemBuilder: (context, i) {
            final style = styles[i];
            return Card(
              child: ListTile(
                title: Text(style, style: const TextStyle(fontSize: 18)),
                trailing: const Icon(Icons.arrow_back),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => ShapeSelectionScreen(selectedStyle: style),
                    ),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}