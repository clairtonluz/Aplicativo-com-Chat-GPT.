import 'package:envied/envied.dart';
part 'env.g.dart';

@Envied(path: ".env")
abstract class Env {
  @EnviedField(varName: 'OPENAI_API_KEY') // the .env variable.
  static const String apiKey = _Env.apiKey;
  @EnviedField(varName: 'ORGANIZATION_ID') // the .env variable.
  static const String organizationId = _Env.organizationId;
}
