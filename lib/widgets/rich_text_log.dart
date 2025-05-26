import 'package:flutter/material.dart';

class RichTextLogController extends ChangeNotifier {
  final List<String> _messages = [];

  List<String> get messages => List.unmodifiable(_messages);

  void addMessage(String message) {
    _messages.add(message);
    notifyListeners();
  }

  void clearMessages() {
    _messages.clear();
    notifyListeners();
  }
}

class RichTextLog extends StatelessWidget {
  final RichTextLogController controller;

  const RichTextLog({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      controller: ScrollController(), // To ensure scrolling to bottom
      itemCount: controller.messages.length,
      itemBuilder: (context, index) {
        return Align(
          alignment: Alignment.centerLeft, // Or right, depending on speaker
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
            padding: const EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              color: Colors.blueGrey[100],
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: Text(
              controller.messages[index],
              style: const TextStyle(fontSize: 16.0),
            ),
          ),
        );
      },
    );
  }
}