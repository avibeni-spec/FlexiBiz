import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'web_open.dart'; // openInNewTab(url) – Web only

class ImageViewerPage extends StatelessWidget {
  final String imageUrl;
  final String provider;
  final String modelUsed;

  const ImageViewerPage({
    super.key,
    required this.imageUrl,
    required this.provider,
    required this.modelUsed,
  });

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: Text('תצוגת תמונה • $provider • $modelUsed'),
          actions: [
            IconButton(
              tooltip: 'פתח בלשונית חדשה',
              onPressed: () => openInNewTab(imageUrl),
              icon: const Icon(Icons.open_in_new),
            ),
            IconButton(
              tooltip: 'העתק קישור',
              onPressed: () async {
                await Clipboard.setData(ClipboardData(text: imageUrl));
                if (context.mounted) {
                  ScaffoldMessenger.of(context)
                      .showSnackBar(const SnackBar(content: Text('קישור התמונה הועתק')));
                }
              },
              icon: const Icon(Icons.link),
            ),
          ],
        ),
        body: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) {
              final double vw = constraints.maxWidth;
              final double vh = constraints.maxHeight;

              // מסגרת קשיחה = כל המסך. FittedBox(BoxFit.contain) מבטיח בלי חיתוך.
              return InteractiveViewer(
                minScale: 0.5,
                maxScale: 5,
                boundaryMargin: const EdgeInsets.all(120),
                child: SizedBox(
                  width: vw,
                  height: vh,
                  child: FittedBox(
                    fit: BoxFit.contain,
                    alignment: Alignment.center,
                    child: Image.network(
                      imageUrl,
                      filterQuality: FilterQuality.high,
                      isAntiAlias: true,
                      loadingBuilder: (c, w, p) {
                        if (p == null) return w;
                        return const Center(child: CircularProgressIndicator());
                      },
                      errorBuilder: (_, __, ___) =>
                          const Center(child: Text('שגיאה בטעינת התמונה')),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}