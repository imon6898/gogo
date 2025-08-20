abstract class AuthApiService {

  Future postSignin(String url,Map<String, dynamic> params);
  Future postRegistration(String url,Map<String, dynamic> params);

}
