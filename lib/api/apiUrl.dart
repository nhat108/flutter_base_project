import 'package:minakomi/config/env.dart';

final versionApi = ''; //if any ~> /1.0;
final baseUrl = AppConfig().baseUrl!;

class APIUrl {
  // AUTHENTICATION
  static final getStarted = "$baseUrl$versionApi/auth/get-started/";
}
