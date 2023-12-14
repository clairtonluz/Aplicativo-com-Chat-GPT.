import 'package:flutter/material.dart';
import 'package:mavie/src/chatgpt/chatgpt_service.dart';
import 'package:mavie/src/chatgpt/chat_message.dart';

/// Displays detailed information about a SampleItem.
class PersonalVirtualView extends StatefulWidget {
  const PersonalVirtualView({super.key});

  static const routeName = '/personal_virtual';

  @override
  State<PersonalVirtualView> createState() => _PersonalVirtualViewState();
}

class _PersonalVirtualViewState extends State<PersonalVirtualView> {
  final ChatGPTService _chatGPTService = ChatGPTService();
  final List<ChatMessage> _messages = <ChatMessage>[
    const ChatMessage(name: chatBot, text: '''Me fale qual o que você precisa? 
ex: 
  "treino para perder a barriga"
  "cronograma de treino para emagrecer com duração de 60 minutos e 3 vezes por semana"'''),
    const ChatMessage(
        name: chatBot, text: 'Bem vindo ao Personal Trainer Virtual!'),
  ];
  final TextEditingController _textController = TextEditingController();
  final _scrollController = ScrollController();
  final _focusNode = FocusNode();

  @override
  void initState() {
    _chatGPTService.init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: const Text('Exercite-se com a Mavie'),
      ),
      body: Column(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () {
                FocusScope.of(context).unfocus(); // <-- Hide virtual keyboard
              },
              child: Align(
                alignment: Alignment.topCenter,
                child: ListView.separated(
                  padding: const EdgeInsets.all(8),
                  shrinkWrap: true,
                  reverse: true,
                  controller: _scrollController,
                  itemCount: _messages.length,
                  itemBuilder: (BuildContext context, int index) {
                    return _messages[index];
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return const Divider();
                  },
                ),
              ),
            ), // <- Chat list view
          ),
          Container(
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
            ),
            child: Builder(builder: (context) {
              return _buildTextComposer(context);
            }),
          ),
        ],
      ),
    );
  }

  void _handleSubmitted(String text) async {
    try {
      addMessageInChat(chatUser, text);

      addMessageInChat(chatBot, '...');

      final historico =
          _messages.sublist(0, _messages.length - 2).map((e) => e).toList();

      const index = 0;

      _chatGPTService.chatPersonalTrainer(text, historico).listen((event) {
        final completation = event.choices.first;

        if (completation.index == 0 && completation.delta.content != null) {
          final response = completation.delta.content;
          setState(() {
            final currentText =
                _messages[index].text == '...' ? '' : _messages[index].text;
            _messages[index] = ChatMessage(
              name: chatBot,
              text: "$currentText${response?.first.text}",
            );
          });
        }
      });

      _scrollController.animateTo(
        0,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );

      _textController.clear();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Erro ao enviar mensagem: $e'),
      ));
    }
  }

  void addMessageInChat(String username, String text) {
    setState(() {
      _messages.insert(
          0,
          ChatMessage(
            name: username,
            text: text,
          ));
    });
  }

  Widget _buildTextComposer(BuildContext context) {
    return IconTheme(
      data: IconThemeData(color: Theme.of(context).colorScheme.secondary),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Row(
          children: <Widget>[
            Flexible(
              child: TextField(
                controller: _textController,
                focusNode: _focusNode,
                onSubmitted: _handleSubmitted,
                decoration: const InputDecoration(
                  hintText: 'Enviar mensagem...',
                  contentPadding: EdgeInsets.all(20),
                ),
              ),
            ),
            IconButton(
              icon: const Icon(Icons.send),
              onPressed: () => _handleSubmitted(_textController.text),
            ),
          ],
        ),
      ),
    );
  }
}
