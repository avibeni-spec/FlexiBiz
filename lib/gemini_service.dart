// אין כאן יבואי dart:js / dart:js_util.
// ייבוא מותנה: אם רץ על Web, ייטען המימוש הוובי; אחרת ייטען Stub.
import 'gemini_service_stub.dart'
  if (dart.library.js) 'gemini_service_web.dart';

/// ממשק אחיד לשימוש בכל האפליקציה
abstract class GeminiService {
  Future<String> generatePrompt({
    required String style,
    required String shape,
    required String purpose,
    required List<String> decorations,
  });

  /// מפעל ליצירת המימוש המתאים לפלטפורמה
  static GeminiService create({
    required String apiKey,
    String model = 'gemini-3-flash-preview',
  }) =>
      GeminiServiceImpl(apiKey: apiKey, model: model);
}