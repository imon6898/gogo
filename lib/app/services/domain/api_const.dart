import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiConstant {

  //final String apiKey
  //BASE URL
  //final String baseUrl = dotenv.get('BASE_URL', fallback: ''); //https://api.mealdealfinder.com/api/v1
  static String baseUrl = dotenv.get('BASE_URL', fallback: ''); //https://api.mealdealfinder.com/api/v1
  static const String getAllRestrurentUri = "/restaurants/get-all";
  static const String loginUri = "/auth/login";
  static const String registrationUri = "/auth/register";





}