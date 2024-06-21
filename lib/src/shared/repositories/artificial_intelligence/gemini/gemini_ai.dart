import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:intellichat/src/shared/repositories/artificial_intelligence/artificial_intelligente.dart';

class GeminiAi implements ArtificialIntelligence {
  final model = GenerativeModel(model: 'gemini-1.5-flash-latest', apiKey: '');

  @override
  Future<String?> sendMessage(String prompt) async {
    try {
      final content = [
        Content.multi([
          TextPart(prompt),
        ])
      ];

      final response = await model.generateContent(content);
      return response.text;
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
