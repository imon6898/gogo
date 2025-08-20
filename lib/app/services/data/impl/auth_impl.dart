
import '../../domain/api_service.dart';
import '../network/auth_api_service.dart';

class AuthImpl extends AuthApiService {
  @override
  Future postSignin(String url, Map<String, dynamic> params) async {
    dynamic response = await ApiService().post(url, params);
    return response;
  }


}
