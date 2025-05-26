class Persona {
  final String name;
  final String preferredName;
  final String missionStatement;
  final String history;
  final String goals;

  Persona({
    required this.name,
    required this.preferredName,
    required this.missionStatement,
    this.history = '',
    this.goals = '',
  });

  factory Persona.fromYaml(Map yamlMap) {
    return Persona(
      name: yamlMap['name'] as String,
      preferredName: yamlMap['preferred_name'] as String,
      missionStatement: yamlMap['mission_statement'] as String,
      history: (yamlMap['history'] as String?) ?? '',
      goals: (yamlMap['goals'] as String?) ?? '',
    );
  }

  Map<String, dynamic> toYaml() {
    return {
      'name': name,
      'preferred_name': preferredName,
      'mission_statement': missionStatement,
      'history': history,
      'goals': goals,
    };
  }
}