import 'gemini_service.dart';

class GeminiServiceImpl implements GeminiService {
  GeminiServiceImpl({required String apiKey, String model = 'gemini-3-flash-preview'});

  @override
  Future<String> generatePrompt({
    required String style,
    required String shape,
    required String purpose,
    required List<String> decorations,
  }) async {
    throw UnsupportedError(
      'GeminiService נתמך כרגע רק ב-Web. הרץ על Chrome: flutter run -d chrome',
    );
  }
}