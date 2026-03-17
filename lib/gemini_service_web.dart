import 'package:dio/dio.dart';
import 'gemini_service.dart';

class GeminiServiceImpl implements GeminiService {
  final String apiKey;
  final String model;

  GeminiServiceImpl({required this.apiKey, required this.model});

  @override
  Future<String> generatePrompt({
    required String style,
    required String shape,
    required String purpose,
    required List<String> decorations,
  }) async {
    final prompt = '''
Create a short photorealistic prompt for an AI image of nail art.
Style: $style
Shape: $shape
Purpose: $purpose
Decorations: ${decorations.join(", ")}
Return one concise English line (<= 200 chars).
''';

    final url =
        'https://generativelanguage.googleapis.com/v1/models/$model:generateContent?key=$apiKey';

    final payload = {
      'contents': [
        {
          'parts': [
            {'text': prompt}
          ]
        }
      ]
    };

    final dio = Dio(
      BaseOptions(
        connectTimeout: const Duration(seconds: 60),
        receiveTimeout: const Duration(seconds: 60),
        headers: {'Content-Type': 'application/json'},
      ),
    );

    try {
      final res = await dio.post(url, data: payload);

      if (res.statusCode != 200) {
        throw Exception('Gemini HTTP ${res.statusCode}: ${res.data}');
      }

      final data = res.data as Map<String, dynamic>;
      final candidates = data['candidates'] as List?;
      if (candidates == null || candidates.isEmpty) {
        throw Exception('No candidates returned from Gemini.');
      }

      final text = candidates[0]['content']['parts'][0]['text'] as String;
      return text.trim();
    } on DioException catch (e) {
      final detail = e.response?.data ?? e.message;
      throw Exception('Gemini request failed: $detail');
    }
  }
}