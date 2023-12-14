// create a service called chatgpt_service.dart:

import 'package:dart_openai/dart_openai.dart';
import 'package:mavie/env/env.dart';
import 'package:mavie/src/chatgpt/chat_message.dart';
import 'package:mavie/src/chatgpt/personal_trainer_contexto.dart';
import 'package:mavie/src/chatgpt/piscologo_contexto.dart';

const chatBot = 'Chat GPT';
const chatUser = 'Você';

class ChatGPTService {
  init() {
    OpenAI.apiKey = Env.apiKey;
    OpenAI.organization = Env.organizationId;
    OpenAI.requestsTimeOut = const Duration(seconds: 60);
    OpenAI.showLogs = true;
    OpenAI.showResponsesLogs = true;
  }

  Stream<OpenAIStreamChatCompletionModel> chatPersonalTrainer(
      String text, List<ChatMessage> historico) {
    return chatGPT4(text, createContextPersonalTrainer(historico));
  }

  Stream<OpenAIStreamChatCompletionModel> chatPsicologo(
      String text, List<ChatMessage> historico) {
    return chatGPT4(text, createContextPsicologo(historico));
  }

  Stream<OpenAIStreamChatCompletionModel> chatGPT4(
      String text, List<OpenAIChatCompletionChoiceMessageModel> context) {
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
}
