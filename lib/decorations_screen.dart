import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'prompt_api.dart';
import 'image_service.dart';
import 'web_open.dart';

const double _kSheetHeightFactor = 0.92;
const double _kSheetWidthFactor  = 1.00;
const double _kHeaderH           = 56;
const double _kFooterH           = 64;
const double _kInsetsSum         = 24;

class DecorationsScreen extends StatefulWidget {
  final String selectedStyle;
  final String selectedShape;

  const DecorationsScreen({
    super.key,
    required this.selectedStyle,
    required this.selectedShape,
  });

  @override
  State<DecorationsScreen> createState() => _DecorationsScreenState();
}

class _DecorationsScreenState extends State<DecorationsScreen> {
  static const List<String> allDecorations = [
    "גליטר","אומברה","פרנץ","אבנים","מדבקות פרחים",
    "קווים גיאומטריים","כרום","מט","דוגמת חיות","נקודות (פולקה)",
  ];
  final Set<String> selectedDecorations = {};
  bool _loading = false;

  Future<void> _createPrompt() async {
    if (selectedDecorations.isEmpty) {
      if (!mounted) { return; }
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('בחרי לפחות קישוט אחד')),
      );
      return;
    }

    setState(() { _loading = true; });
    final ctx = context;

    String? errorText;
    String? promptText;

    try {
      final api = PromptApi();
      final prompt = await api.buildPrompt(
        style: widget.selectedStyle,
        shape: widget.selectedShape,
        purpose: "לאירוע",
        decorations: selectedDecorations.toList(),
      );
      promptText = prompt;
    } catch (e) {
      errorText = "שגיאה ביצירת prompt: $e";
    } finally {
      if (mounted) { setState(() { _loading = false; }); }
    }

    if (!ctx.mounted) { return; }

    if (errorText != null) {
      ScaffoldMessenger.of(ctx).showSnackBar(
        SnackBar(content: Text(errorText, textDirection: TextDirection.rtl)),
      );
      return;
    }

    final prompt = promptText!;
    _showPromptDialog(ctx, prompt);
  }

  void _showPromptDialog(BuildContext ctx, String prompt) {
    showDialog<void>(
      context: ctx,
      builder: (_) => AlertDialog(
        title: const Text("Prompt שנוצר"),
        content: SelectableText(prompt, textDirection: TextDirection.ltr),
        actions: [
          TextButton(
            onPressed: () async {
              await Clipboard.setData(ClipboardData(text: prompt));
              if (!ctx.mounted) { return; }
              ScaffoldMessenger.of(ctx).showSnackBar(
                const SnackBar(content: Text('ה‑Prompt הועתק')),
              );
            },
            child: const Text("העתק"),
          ),
          FilledButton.icon(
            icon: const Icon(Icons.image),
            label: const Text("צור תמונה"),
            onPressed: () async {
              Navigator.pop(ctx);
              if (!ctx.mounted) { return; }

              setState(() { _loading = true; });
              try {
                final imgSvc = ImageService();

                // חיזוק אומברה + אנטומיה (הדבקה 1:1)
                const promptAugment = """
A photorealistic, professional nail art photo.
Nail style: Soft pink ombre almond nails — a smooth vertical gradient from light near the cuticle to deeper pink towards the tips; flawless blend, subtle sheen.
Hand composition: Natural relaxed pose, fingers slightly separated, thumb clearly visible near the palm side; clean separation between all fingers.
Anatomically correct human hand, exactly five fingers with realistic joints and proportions.
Lighting & background: Soft diffused studio light, gentle shadows, neutral clean background.
""";

                const negative = """
six fingers, extra finger, extra fingers, seven fingers, double thumb, duplicated thumb,
fused fingers, merged fingers, webbed fingers, missing fingers, distorted wrist,
warped hand, deformed hand, wrong anatomy, mangled hand, broken anatomy, warped nails
""";

                final result = await imgSvc.generate(
                  prompt: "$prompt\n\n$promptAugment",
                  negativePrompt: negative,
                  steps: 36,
                  guidance: 4.8,
                  width: 768,
                  height: 1024,
                  numImages: 2,
                  seed: 12345, // אופציונלי: עקביות בין ריצות
                );

                if (!ctx.mounted) { return; }
                _showImageBottomSheet(ctx, result.imageUrl, result.provider, result.modelUsed);
              } catch (e) {
                if (!ctx.mounted) { return; }
                ScaffoldMessenger.of(ctx).showSnackBar(
                  SnackBar(content: Text("שגיאה ביצירת תמונה: $e",
                      textDirection: TextDirection.rtl)),
                );
              } finally {
                if (mounted) { setState(() { _loading = false; }); }
              }
            },
          ),
          FilledButton(
            onPressed: () { Navigator.pop(ctx); },
            child: const Text("סגור"),
          ),
        ],
      ),
    );
  }

  void _showImageBottomSheet(BuildContext ctx, String imageUrl, String provider, String modelUsed) {
    final Size screen = MediaQuery.of(ctx).size;

    showModalBottomSheet<void>(
      context: ctx,
      isScrollControlled: true,
      useSafeArea: true,
      backgroundColor: Colors.transparent,
      builder: (sheetCtx) {
        final bool isDemo = provider.toLowerCase() == 'demo';
        final double maxSheetH = (screen.height * _kSheetHeightFactor).clamp(320.0, 1400.0);
        final double maxSheetW = (screen.width  * _kSheetWidthFactor ).clamp(320.0, 1400.0);

        return Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(maxHeight: maxSheetH, maxWidth: maxSheetW),
            child: Material(
              color: Theme.of(sheetCtx).dialogBackgroundColor,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              clipBehavior: Clip.antiAlias,
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final double availableH =
                      (constraints.maxHeight - _kHeaderH - _kFooterH - _kInsetsSum)
                          .clamp(140.0, constraints.maxHeight);
                  final double availableW =
                      (constraints.maxWidth - 24).clamp(160.0, constraints.maxWidth);

                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(12, 12, 12, 0),
                        child: Row(
                          children: [
                            const Expanded(
                              child: Text("תמונה שנוצרה",
                                  style: TextStyle(fontWeight: FontWeight.w600)),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                color: Colors.black12, borderRadius: BorderRadius.circular(6),
                              ),
                              child: Text("$provider • $modelUsed",
                                  style: const TextStyle(fontSize: 12),
                                  textDirection: TextDirection.ltr),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 8),

                      // מסגרת קשיחה + contain — אין Overflow ולא "חצי יד".
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: SizedBox(
                          width: availableW,
                          height: availableH,
                          child: FittedBox(
                            fit: BoxFit.contain,
                            alignment: Alignment.center,
                            child: Image.network(
                              imageUrl,
                              filterQuality: FilterQuality.high,
                              isAntiAlias: true,
                              loadingBuilder: (c, w, p) {
                                if (p == null) { return w; }
                                return const Center(child: CircularProgressIndicator());
                              },
                              errorBuilder: (_, __, ___) =>
                                  const Center(child: Text('שגיאה בטעינת התמונה')),
                            ),
                          ),
                        ),
                      ),

                      if (isDemo)
                        const Padding(
                          padding: EdgeInsets.only(top: 4),
                          child: Text(
                            "תצוגת דמו: זוהי תמונת פלייסהולדר עד להטענת קרדיט בספק",
                            style: TextStyle(fontSize: 12, color: Colors.redAccent),
                            textAlign: TextAlign.center,
                          ),
                        ),

                      Padding(
                        padding: const EdgeInsets.fromLTRB(12, 8, 12, 12),
                        child: Row(
                          children: [
                            TextButton.icon(
                              icon: const Icon(Icons.open_in_new),
                              label: const Text("פתח בלשונית חדשה"),
                              style: TextButton.styleFrom(
                                foregroundColor: Colors.blue,
                                textStyle: const TextStyle(fontWeight: FontWeight.w600),
                              ),
                              onPressed: () { openInNewTab(imageUrl); },
                            ),
                            const SizedBox(width: 8),
                            OutlinedButton.icon(
                              icon: const Icon(Icons.link),
                              label: const Text("העתק קישור"),
                              onPressed: () async {
                                await Clipboard.setData(ClipboardData(text: imageUrl));
                                if (!sheetCtx.mounted) { return; }
                                ScaffoldMessenger.of(sheetCtx).showSnackBar(
                                  const SnackBar(content: Text("קישור התמונה הועתק")),
                                );
                              },
                            ),
                            const Spacer(),
                            FilledButton(
                              onPressed: () { Navigator.pop(sheetCtx); },
                              child: const Text("סגור"),
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: Text("קישוטים • ${widget.selectedStyle} • ${widget.selectedShape}"),
          centerTitle: true,
        ),
        body: Column(
          children: [
            const SizedBox(height: 12),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Align(
                alignment: Alignment.centerRight,
                child: Text(
                  "בחרי קישוטים (אפשר כמה):",
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
              ),
            ),
            const SizedBox(height: 8),

            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.all(16),
                itemCount: allDecorations.length,
                separatorBuilder: (_, __) => const SizedBox(height: 8),
                itemBuilder: (context, i) {
                  final item = allDecorations[i];
                  final isSelected = selectedDecorations.contains(item);
                  return Card(
                    child: CheckboxListTile(
                      title: Text(item),
                      value: isSelected,
                      controlAffinity: ListTileControlAffinity.leading,
                      onChanged: _loading
                          ? null
                          : (v) {
                              setState(() {
                                if (v == true) { selectedDecorations.add(item); }
                                else { selectedDecorations.remove(item); }
                              });
                            },
                    ),
                  );
                },
              ),
            ),

            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              child: FilledButton.icon(
                icon: _loading
                    ? const SizedBox(width: 16, height: 16,
                        child: CircularProgressIndicator(strokeWidth: 2))
                    : const Icon(Icons.auto_awesome),
                label: const Text("צור Prompt (תצוגה מקדימה)"),
                onPressed: _loading || selectedDecorations.isEmpty
                    ? null
                    : () { _createPrompt(); },
              ),
            ),
          ],
        ),
      ),
    );
  }
}