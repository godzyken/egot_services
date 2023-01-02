import 'package:envied/envied.dart';

part 'env.g.dart';

@Envied(path: 'assets/.env')
abstract class Env {
  @EnviedField(varName: 'S_API_KEY', obfuscate: true)
  static final sApiKey = _Env.sApiKey;

  @EnviedField(varName: 'FB_API_KEY', obfuscate: true)
  static final fbApiKey = _Env.fbApiKey;

  @EnviedField(varName: 'CC_AUTH_KEY', obfuscate: true)
  static final ccApiKey = _Env.ccApiKey;

  @EnviedField(varName: 'CC_AUTH_SECRET', obfuscate: true)
  static final ccSecretKey = _Env.ccSecretKey;
}
