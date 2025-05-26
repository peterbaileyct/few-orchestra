import 'package:few_orchestra/agents/base_agent.dart';
import 'package:few_orchestra/models/persona.dart';
import 'package:few_orchestra/services/intelligence_provider.dart';

class Agent extends BaseAgent {
  final bool isVisualArtist;

  Agent(Persona persona, IntelligenceProvider intelligenceProvider, {this.isVisualArtist = false})
      : super(persona, intelligenceProvider);

  @override
  Future<String> processMessage(String message) async {
    // The prompt sent to the LLM for this agent
    final String fullPrompt = "FROM Angel/Other_Agent: $message\nYour personality is as follows: ${persona.missionStatement}\nRespond to the message.";
    
    if (isVisualArtist) {
      // For Ernst, this would trigger an image generation call
      // await intelligenceProvider.getImage(message, persona);
      return "Conceptual image generated for: '$message'";
    } else {
      // For other agents, process text
      return await intelligenceProvider.getCompletion(fullPrompt, persona);
    }
  }
}