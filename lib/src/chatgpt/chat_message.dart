import 'package:flutter/material.dart';
import 'package:mavie/src/chatgpt/chatgpt_service.dart';
import 'package:mavie/src/psicologo_virtual/psicologo_virtual_view.dart';

class ChatMessage extends StatelessWidget {
  final String text;
  final String name;

  const ChatMessage({super.key, required this.name, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          Expanded(
            child: Column(
              crossAxisAlignment:
                  isBot ? CrossAxisAlignment.start : CrossAxisAlignment.end,
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    color: isBot ? Colors.green : Colors.blue,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(8.0),
                      topRight: Radius.circular(8.0),
                      bottomLeft: Radius.circular(8.0),
                    ),
                  ),
                  child: Text(
                    text,
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  bool get isBot => name == chatBot;

  String getInitials(String fullName) {
    List<String> nameParts = fullName.split(" ");
    String initials = "";

    for (var part in nameParts) {
      if (part.isNotEmpty) {
        initials += part[0].toUpperCase();
      }
    }

    return initials;
  }
}
