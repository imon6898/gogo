import 'package:gogo/app/feature/auth/auth_logic/auth_api_service.dart';
import 'package:gogo/app/feature/auth/auth_logic/auth_impl.dart';
import 'package:gogo/app/services/domain/api_const.dart';

class AuthRepo {
  final AuthApiService authApiService = AuthImpl();

  Future<dynamic>? postLoginRepo(Map<String, dynamic> params) async {
    dynamic responseData = await authApiService.postSignin(ApiConstant.loginUri, params);
    return responseData;
  }

  Future<dynamic>? postRegistrationRepo(Map<String, dynamic> params) async {
    dynamic responseData = await authApiService.postSignin(ApiConstant.registrationUri, params);
    return responseData;
  }

}
