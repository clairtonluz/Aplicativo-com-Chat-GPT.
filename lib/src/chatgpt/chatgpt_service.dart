// create a service called chatgpt_service.dart:

import 'package:dart_openai/dart_openai.dart';
import 'package:mavie/env/env.dart';
import 'package:mavie/src/chatgpt/chat_message.dart';

const chatBot = 'Chat GPT';
const chatUser = 'Você';

class ChatGPTService {
  init() {
    // OpenAI.apiKey = Env.apiKey;
    OpenAI.organization = Env.organizationId;
    OpenAI.requestsTimeOut = const Duration(seconds: 60);
    // OpenAI.baseUrl = "https://api.openai.com/v1"; // the default one.
    OpenAI.showLogs = true;
    OpenAI.showResponsesLogs = true;
  }

  Stream<OpenAIStreamChatCompletionModel> chatPersonalTrainer(
      String text, List<ChatMessage> historico) {
    return chatGPT4(text, historico, _createContextPersonalTrainer(historico));
  }

  Stream<OpenAIStreamChatCompletionModel> chatPsicologo(
      String text, List<ChatMessage> historico) {
    return chatGPT4(text, historico, _createContextPsicologo(historico));
  }

  Stream<OpenAIStreamChatCompletionModel> chatGPT4(
      String text,
      List<ChatMessage> historico,
      List<OpenAIChatCompletionChoiceMessageModel> context) {
    List<OpenAIChatCompletionChoiceMessageModel> context =
        _createContextPsicologo(historico);
    context.add(
      OpenAIChatCompletionChoiceMessageModel(
        content: [
          OpenAIChatCompletionChoiceMessageContentItemModel.text(
            text,
          ),
        ],
        role: OpenAIChatMessageRole.user,
      ),
    );
    // The request to be sent.
    return OpenAI.instance.chat.createStream(
      model: "gpt-4",
      messages: context,
      seed: 423,
      n: 1,
    );
  }

  List<OpenAIChatCompletionChoiceMessageModel> _createContextPsicologo(
      List<ChatMessage> historico) {
    final context = [
      OpenAIChatCompletionChoiceMessageModel(
        content: [
          OpenAIChatCompletionChoiceMessageContentItemModel.text(
            'Você é um excelente psicólogo!',
          ),
        ],
        role: OpenAIChatMessageRole.system,
      ),
      ...historico.map((e) => OpenAIChatCompletionChoiceMessageModel(
            content: [
              OpenAIChatCompletionChoiceMessageContentItemModel.text(
                e.text,
              ),
            ],
            role: e.name == chatBot
                ? OpenAIChatMessageRole.assistant
                : OpenAIChatMessageRole.user,
          ))
    ];
    return context;
  }

  List<OpenAIChatCompletionChoiceMessageModel> _createContextPersonalTrainer(
      List<ChatMessage> historico) {
    final context = [
      OpenAIChatCompletionChoiceMessageModel(
        content: [
          OpenAIChatCompletionChoiceMessageContentItemModel.text(
            'Vamos falar apenas sobre exercicios físico, Fale como se fosse um personal trainer profissional.',
          ),
        ],
        role: OpenAIChatMessageRole.system,
      ),
      ...historico.map((e) => OpenAIChatCompletionChoiceMessageModel(
            content: [
              OpenAIChatCompletionChoiceMessageContentItemModel.text(
                e.text,
              ),
            ],
            role: e.name == chatBot
                ? OpenAIChatMessageRole.assistant
                : OpenAIChatMessageRole.user,
          ))
    ];
    return context;
  }
}
