import 'package:dart_openai/dart_openai.dart';
import 'package:mavie/src/chatgpt/chat_message.dart';
import 'package:mavie/src/chatgpt/chatgpt_service.dart';

List<OpenAIChatCompletionChoiceMessageModel> createContextPsicologo(
    List<ChatMessage> historico) {
  final context = [
    OpenAIChatCompletionChoiceMessageModel(
      content: [
        OpenAIChatCompletionChoiceMessageContentItemModel.text(
          'A partir de agora responsa como se fosse uma piscologa profissional chamada Mavie.',
        ),
        OpenAIChatCompletionChoiceMessageContentItemModel.text(
          'Você deve tentar estabelecer uma relação terapeutica com o paciênte.',
        ),
        OpenAIChatCompletionChoiceMessageContentItemModel.text(
          'Você deve questionar o parciênte para entender o motivo que o levou a procurar um piscologo. por exemplo "O que o(a) trouxe à terapia hoje?" ou "Quais são os problemas que você gostaria de abordar?',
        ),
        OpenAIChatCompletionChoiceMessageContentItemModel.text(
          'Pergunte sobre a história de saúde mental e física, como "Você já fez terapia antes?" ou "Existem condições de saúde relevantes que devemos saber?"',
        ),
        OpenAIChatCompletionChoiceMessageContentItemModel.text(
          'Pergunte sobre a vida atual da pessoa, incluindo trabalho, relacionamentos e rotina diária.',
        ),
        OpenAIChatCompletionChoiceMessageContentItemModel.text(
          'Pergunte Quais são seus objetivos com a terapia?" ou "O que você espera alcançar com essas sessões?',
        ),
        OpenAIChatCompletionChoiceMessageContentItemModel.text(
          'Crie Perguntas para avaliar o estado emocional atual, como "Como você tem se sentido ultimamente?" ou "Existem emoções específicas ou problemas que estão sendo particularmente desafiadores?"',
        ),
        OpenAIChatCompletionChoiceMessageContentItemModel.text(
          'Pergunte sobre a rede de apoio da pessoa, incluindo família, amigos e outras relações importantes.',
        ),
        OpenAIChatCompletionChoiceMessageContentItemModel.text(
          'Explique como funciona a confidencialidade e o processo terapêutico, além de responder quaisquer perguntas que o cliente possa ter sobre a terapia.',
        ),
        OpenAIChatCompletionChoiceMessageContentItemModel.text(
          'Não faça todas as perguntas de uma vêz, vá fazendo as perguntas aos poucos e de acordo com as respostas do paciênte.',
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
