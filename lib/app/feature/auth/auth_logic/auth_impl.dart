import 'package:gogo/app/feature/auth/auth_logic/auth_api_service.dart';
import 'package:gogo/app/feature/home/home_logic/home_api_service.dart';
import 'package:gogo/app/services/domain/api_service.dart';

class AuthImpl extends AuthApiService {

  @override
  Future postSignin(String url, Map<String, dynamic> params) async {
    dynamic response = await ApiService().post(url, params);
    return response;
  }

  @override
  Future postRegistration(String url, Map<String, dynamic> params) async {
    dynamic response = await ApiService().post(url, params);
    return response;
  }

}
