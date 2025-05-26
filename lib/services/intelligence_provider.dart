import 'package:few_orchestra/models/persona.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

abstract class IntelligenceProvider {
  Future<String> getCompletion(String prompt, Persona persona);
  Future<List<int>> getImage(String prompt, Persona persona); // For visual agents
}

class ChatGPTProvider implements IntelligenceProvider {
  final String apiKey;
  final String _baseUrl = 'https://api.openai.com/v1/chat/completions'; // Or image generation endpoint

  ChatGPTProvider(this.apiKey);

  @override
  Future<String> getCompletion(String prompt, Persona persona) async {
    // This is a simplified example. Real implementation would handle context,
    // roles, etc.
    final response = await http.post(
      Uri.parse(_baseUrl),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $apiKey',
      },
      body: jsonEncode({
        'model': 'gpt-3.5-turbo', // Or a suitable model
        'messages': [
          {"role": "system", "content": "You are an AI agent. Your personality is as follows: ${persona.missionStatement}"},
          {"role": "user", "content": prompt}
        ],
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['choices'][0]['message']['content'];
    } else {
      throw Exception('Failed to get completion from ChatGPT: ${response.body}');
    }
  }

  @override
  Future<List<int>> getImage(String prompt, Persona persona) async {
    // This is a placeholder for an image generation API call (e.g., DALL-E)
    // Replace with actual image generation logic
    print("Generating image for prompt: '$prompt' by ${persona.name}");
    // Simulate image data or return an empty list
    return Future.value([]);
  }
}