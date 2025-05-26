import 'package:few_orchestra/agents/base_agent.dart';
import 'package:few_orchestra/models/persona.dart';
import 'package:few_orchestra/services/intelligence_provider.dart';
import 'package:few_orchestra/agents/agent.dart'; // Import to use Agent type

class BossAgent extends BaseAgent {
  BossAgent(Persona persona, IntelligenceProvider intelligenceProvider)
      : super(persona, intelligenceProvider);

  @override
  Future<String> processMessage(String message) async {
    // The prompt sent to the LLM for the Boss agent
    final String fullPrompt = "FROM Angel: $message\nYour personality is as follows: ${persona.missionStatement}\nYou are the ombudsman between an 'angel' non-AI program and multiple other AI agents. You will be given a directed graph in Mermaid format explaining which other agents you can interact with. Your subsequent responses should begin with the GUID of the intended recipient.";

    // In a real scenario, the Boss would parse the message and direct it.
    // This is a simplified conceptual processing.
    return await intelligenceProvider.getCompletion(fullPrompt, persona);
  }

  // A conceptual method for the Boss to direct messages
  Future<String> directMessage(String message, Map<String, BaseAgent> agents) async {
    // This method would parse the GUID and route the message
    // Example: "GUID-of-Agent: actual message"
    // For now, it's a placeholder for the Boss's routing logic.
    print("Boss attempting to direct message: '$message'");
    // This would involve LLM reasoning to determine recipient and message content.
    return "Message conceptually directed by Boss.";
  }
}