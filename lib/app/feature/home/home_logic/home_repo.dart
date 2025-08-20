import 'package:gogo/app/feature/home/home_logic/home_api_service.dart';
import 'package:gogo/app/feature/home/home_logic/home_impl.dart';
import 'package:gogo/app/services/domain/api_const.dart';


class HomeRepo {
  final HomeApiService homeApiService = HomeImpl();

  Future<dynamic>? getAllResturentRepo(Map<String, dynamic> params) async {
    dynamic responseData = await homeApiService.getAllResturentService(ApiConstant.getAllRestrurentUri, params);
    return responseData;  // Return responseData directly
  }

}
