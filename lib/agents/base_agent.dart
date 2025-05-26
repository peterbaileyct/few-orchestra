import 'package:few_orchestra/models/persona.dart';
import 'package:few_orchestra/services/intelligence_provider.dart';

abstract class BaseAgent {
  final Persona persona;
  final IntelligenceProvider intelligenceProvider;

  BaseAgent(this.persona, this.intelligenceProvider);

  Future<String> processMessage(String message);
}