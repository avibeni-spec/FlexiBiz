import 'package:dio/dio.dart';

const String _kProxyBaseUrl = 'https://nailai-proxy.onrender.com';

class PromptApi {
  final Dio _dio;

  PromptApi([String baseUrl = _kProxyBaseUrl])
      : _dio = Dio(
          BaseOptions(
            baseUrl: baseUrl,
            headers: const {'Content-Type': 'application/json'},
            connectTimeout: const Duration(seconds: 30),
            receiveTimeout: const Duration(seconds: 60),
          ),
        );

  Future<String> buildPrompt({
    required String style,
    required String shape,
    required String purpose,
    required List<String> decorations,
  }) async {
    try {
      final res = await _dio.post('/prompt', data: {
        'style': style,
        'shape': shape,
        'purpose': purpose,
        'decorations': decorations,
      });
      if (res.statusCode != 200) {
        throw Exception('Proxy error: ${res.statusCode} ${res.data}');
      }
      final data = res.data as Map<String, dynamic>;
      final prompt = (data['prompt'] as String?)?.trim();
      if (prompt == null || prompt.isEmpty) {
        throw Exception('No prompt returned from proxy');
      }
      return prompt;
    } on DioException catch (e) {
      throw Exception('Prompt request failed: ${e.response?.data ?? e.message}');
    }
  }
}