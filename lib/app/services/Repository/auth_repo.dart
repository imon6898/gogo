import '../data/impl/auth_impl.dart';
import '../data/network/auth_api_service.dart';
import '../domain/api_const.dart';

class AuthRepo {
  final AuthApiService appApiService = AuthImpl();

  Future<dynamic>? postLoginRepo(Map<String, dynamic> params) async {
    dynamic responseData = await appApiService.postSignin(ApiConstant.studentLogin, params);
    return responseData;  // Return responseData directly
  }

}

