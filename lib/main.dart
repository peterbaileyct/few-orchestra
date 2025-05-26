import 'package:flutter/material.dart';
import 'package:few_orchestra/services/api_key_storage.dart';
import 'package:few_orchestra/models/persona.dart';
import 'package:few_orchestra/services/intelligence_provider.dart';
import 'package:few_orchestra/widgets/rich_text_log.dart';
import 'package:few_orchestra/agents/boss_agent.dart';
import 'package:few_orchestra/agents/agent.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:yaml/yaml.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() {
  runApp(const FEWOrchestraApp());
}

class FEWOrchestraApp extends StatefulWidget {
  const FEWOrchestraApp({super.key});

  @override
  State<FEWOrchestraApp> createState() => _FEWOrchestraAppState();
}

class _FEWOrchestraAppState extends State<FEWOrchestraApp> {
  final RichTextLogController _logController = RichTextLogController();
  String? _chatGptApiKey;
  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();
    // No longer needed, as we handle this in the build method now
  }

  Future<void> _setupAgentsAndOrchestration() async {
    _logController.addMessage('Initializing Orchestra...');

    // Load personas from YAML
    final String personasYamlString = await rootBundle.loadString('assets/data/personas.yaml');
    final yamlMap = loadYaml(personasYamlString) as Map;
    final Map<String, Persona> personas = {};
    yamlMap['personas'].forEach((key, value) {
      personas[key] = Persona.fromYaml(value as Map);
    });

    // 2. Create Intelligence Provider
    final IntelligenceProvider chatGptProvider = ChatGPTProvider(_chatGptApiKey!);
    _logController.addMessage('Intelligence Provider (ChatGPT) created.');

    // 3. Create Agents with Personas
    final BossAgent bob = BossAgent(personas['bob_persona']!, chatGptProvider);
    final Agent charlie = Agent(personas['charlie_persona']!, chatGptProvider);
    final Agent doris = Agent(personas['doris_persona']!, chatGptProvider);
    final Agent ernst = Agent(personas['ernst_persona']!, chatGptProvider, isVisualArtist: true); // Ernst has visual capability

    _logController.addMessage('Agents created.');

    // 4. Initialize Bob as the Boss and prompt him
    const String bossPrompt = """Seek agreement between Charlie and Doris on which technology to use on our new application. When this is done, describe the discussion to the user, and have Ernst depict it visually. Give a text description of each exchange between agents to the user.""";
    
    // Mermaid diagram for Bob's interaction capabilities (conceptual representation for the LLM)
    const String mermaidDiagram = """
    graph LR
      Bob -- Text Output --> User[User Output]
      Bob -- Talk --> Charlie[Agent Charlie]
      Bob -- Talk --> Doris[Agent Doris]
      Bob -- Talk --> Ernst[Agent Ernst]
      Ernst -- Visual Output --> User[User Output]
    """;
    
    _logController.addMessage('Boss (Bob) initialized with goal and communication graph.');
    
    // In a real implementation, you would pass the diagram and prompt to Bob's LLM context.
    // For this conceptual code, we simulate the start of the symphony.
    _logController.addMessage('\nStarting the Symphony...');

    // Simulate the initial prompt to Bob (from Angel/Alice)
    _logController.addMessage('Angel: Start the discussion.');
    _logController.addMessage('Bob: Initiating discussion with Charlie and Doris...');
    
    // Conceptual interaction loop would follow here, where messages are sent
    // and received by agents, and the RichTextLog is updated.
    // For instance:
    // String bobResponse = await bob.processMessage("FROM Angel: Start the discussion.", {
    //   'charlie': charlie,
    //   'doris': doris,
    //   'ernst': ernst
    // });
    // _logController.addMessage('Bob: $bobResponse');
    // ... further simulated interactions based on Bob's directive

    _logController.addMessage('\nSymphony in progress (conceptual simulation).');
  }

  @override
  Widget build(BuildContext context) {
  return MaterialApp(
    title: 'FEW Orchestra',
    theme: ThemeData(
      primarySwatch: Colors.blue,
    ),
    localizationsDelegates: const [
      GlobalMaterialLocalizations.delegate,
      GlobalWidgetsLocalizations.delegate,
      GlobalCupertinoLocalizations.delegate,
    ],
    supportedLocales: const [
      Locale('en', ''), // English
    ],
    home: Builder(
      builder: (context) {
        // Schedule API key check after the first frame
        WidgetsBinding.instance.addPostFrameCallback((_) {
          _checkApiKey(context);
        });
        
        return Scaffold(
          appBar: AppBar(
            title: const Text('FEW Orchestra'),
          ),
          body: _isInitialized 
            ? RichTextLog(controller: _logController)
            : const Center(child: CircularProgressIndicator()),
        );
      },
    ),
  );
}

Future<void> _checkApiKey(BuildContext context) async {
  _chatGptApiKey = await ApiKeyStorage.getApiKey();
  if (_chatGptApiKey == null) {
    _showApiKeyDialog(context);
  } else {
    await _setupAgentsAndOrchestration();
    setState(() {
      _isInitialized = true;
    });
  }
}

Future<void> _showApiKeyDialog(BuildContext context) async {
  String? enteredKey = await showDialog<String>(
    context: context,
    barrierDismissible: false, // User must enter API key
    builder: (BuildContext context) {
      String tempKey = '';
      return AlertDialog(
        title: const Text('Enter ChatGPT API Key'),
        content: TextField(
          onChanged: (value) {
            tempKey = value;
          },
          decoration: const InputDecoration(hintText: 'sk-...'),
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('Save'),
            onPressed: () {
              Navigator.of(context).pop(tempKey);
            },
          ),
        ],
      );
    },
  );

  if (enteredKey != null && enteredKey.isNotEmpty) {
    await ApiKeyStorage.saveApiKey(enteredKey);
    _chatGptApiKey = enteredKey;
    await _setupAgentsAndOrchestration();
    setState(() {
      _isInitialized = true;
    });
  } else {
    _logController.addMessage('API Key not provided. Application cannot proceed.');
  }
}
}