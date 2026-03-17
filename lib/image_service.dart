import 'package:dio/dio.dart';

/// כתובת ה‑Proxy שלך (החלף אם שינית)
const String _kProxyBaseUrl = 'https://nailai-proxy.onrender.com';

class ImageResult {
  final String imageUrl;
  final String provider;
  final String modelUsed;

  const ImageResult({
    required this.imageUrl,
    required this.provider,
    required this.modelUsed,
  });
}

class ImageService {
  final Dio _dio;

  ImageService([String baseUrl = _kProxyBaseUrl])
      : _dio = Dio(
          BaseOptions(
            baseUrl: baseUrl,
            headers: const {'Content-Type': 'application/json'},
            connectTimeout: const Duration(seconds: 30),
            receiveTimeout: const Duration(seconds: 120),
          ),
        );

  /// השרת ממפה ל‑Leonardo:
  /// steps->num_inference_steps, guidance->guidance_scale, negativePrompt->negative_prompt, seed->seed
  Future<ImageResult> generate({
    required String prompt,
    String? negativePrompt,
    int width = 768,
    int height = 1024,
    int steps = 36,
    double guidance = 4.8,
    int numImages = 2,
    int? seed, // ← פרמטר חדש
  }) async {
    try {
      final Map<String, dynamic> payload = {
        'prompt': prompt,
        'width': width,
        'height': height,
        'steps': steps,
        'guidance': guidance,
        'numImages': numImages,
        if (negativePrompt != null && negativePrompt.trim().isNotEmpty)
          'negativePrompt': negativePrompt,
        if (seed != null) 'seed': seed, // ← נשלח רק אם הועבר
      };

      final res = await _dio.post('/image', data: payload);
      if (res.statusCode != 200) {
        throw Exception('Image error: ${res.statusCode} ${res.data}');
      }

      final data = (res.data is Map<String, dynamic>)
          ? res.data as Map<String, dynamic>
          : <String, dynamic>{};

      final String? url = data['imageUrl'] as String?;
      if (url == null || url.isEmpty) {
        throw Exception('No imageUrl in response');
      }

      return ImageResult(
        imageUrl: url,
        provider: (data['provider'] as String?) ?? 'leonardo',
        modelUsed: (data['modelUsed'] as String?) ?? '',
      );
    } on DioException catch (e) {
      final dynamic body = e.response?.data ?? e.message;
      throw Exception('Image request failed: $body');
    } catch (e) {
      throw Exception('Image request failed: $e');
    }
  }
}