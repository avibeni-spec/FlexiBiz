import 'package:flutter/material.dart';
import 'decorations_screen.dart';

class ShapeSelectionScreen extends StatelessWidget {
  final String selectedStyle;
  const ShapeSelectionScreen({super.key, required this.selectedStyle});

  static const List<String> shapes = [
    "שקד",
    "עגול",
    "מרובע",
    "סטילטו",
    "בלרינה",
    "אליפסה",
  ];

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: Text("בחרי צורה • $selectedStyle"),
          centerTitle: true,
        ),
        body: ListView.separated(
          padding: const EdgeInsets.all(16),
          itemCount: shapes.length,
          separatorBuilder: (_, __) => const SizedBox(height: 8),
          itemBuilder: (context, i) {
            final shape = shapes[i];
            return Card(
              child: ListTile(
                title: Text(shape, style: const TextStyle(fontSize: 18)),
                trailing: const Icon(Icons.arrow_back),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => DecorationsScreen(
                        selectedStyle: selectedStyle,
                        selectedShape: shape,
                      ),
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