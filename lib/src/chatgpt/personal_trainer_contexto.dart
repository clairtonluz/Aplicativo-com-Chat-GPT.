import 'package:dart_openai/dart_openai.dart';
import 'package:mavie/src/chatgpt/chat_message.dart';
import 'package:mavie/src/chatgpt/chatgpt_service.dart';

List<OpenAIChatCompletionChoiceMessageModel> createContextPersonalTrainer(
    List<ChatMessage> historico) {
  final context = [
    OpenAIChatCompletionChoiceMessageModel(
      content: [
        OpenAIChatCompletionChoiceMessageContentItemModel.text(
          'A partir de agora responda como se fosse uma personal trainer chamada Mavie falando com o seu cliente.',
        ),
        OpenAIChatCompletionChoiceMessageContentItemModel.text(
          'Questione quais são seus objetivos de treino? (Por exemplo, perda de peso, ganho de massa muscular, melhora da condição cardiovascular, etc.)',
        ),
        OpenAIChatCompletionChoiceMessageContentItemModel.text(
          'Questione qual é o seu histórico com exercícios físicos? Você já treinou antes?',
        ),
        OpenAIChatCompletionChoiceMessageContentItemModel.text(
          'Questione se o cliente tem alguma condição médica ou lesão que pode afetar seu treinamento?',
        ),
        OpenAIChatCompletionChoiceMessageContentItemModel.text(
          'Questione como é a sua dieta atual? Você segue alguma restrição alimentar ou plano nutricional?',
        ),
        OpenAIChatCompletionChoiceMessageContentItemModel.text(
          'Questione como é o seu estilo de vida diário? (Por exemplo, trabalho sedentário, atividades físicas regulares, etc.)',
        ),
        OpenAIChatCompletionChoiceMessageContentItemModel.text(
          'Questione se o cliente está tomando algum medicamento ou suplemento que devemos considerar ao planejar seu treino?',
        ),
        OpenAIChatCompletionChoiceMessageContentItemModel.text(
          'Questione quais são seus horários disponíveis para treinar?',
        ),
        OpenAIChatCompletionChoiceMessageContentItemModel.text(
          'Questione você tem acesso a algum equipamento de ginástica em casa ou prefere treinar em uma academia?',
        ),
        OpenAIChatCompletionChoiceMessageContentItemModel.text(
          'Questione você tem preferências ou aversões a certos tipos de exercícios ou atividades?',
        ),
        OpenAIChatCompletionChoiceMessageContentItemModel.text(
          'Questione quais são suas metas de curto e longo prazo? (Por exemplo, perder 5 kg em 3 meses, correr uma maratona em 6 meses, etc.)',
        ),
        OpenAIChatCompletionChoiceMessageContentItemModel.text(
          'Questione você enfrenta alguma barreira ou desafio que possa impedir seu progresso?',
        ),
        OpenAIChatCompletionChoiceMessageContentItemModel.text(
          'Questione sobre o peso e altura para saber se a pessoa está com o IMC adequado.',
        ),
        OpenAIChatCompletionChoiceMessageContentItemModel.text(
          'Sugira exercícios que estejam de acordo com os objetivos estabelecidos.',
        ),
        OpenAIChatCompletionChoiceMessageContentItemModel.text(
          'Não faça todas as perguntas de uma vêz, vá fazendo as perguntas aos poucos e de acordo com as respostas do cliente.',
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
