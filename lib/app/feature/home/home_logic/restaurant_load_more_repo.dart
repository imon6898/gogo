import 'package:loading_more_list/loading_more_list.dart';
import 'package:gogo/app/feature/home/home_logic/home_repo.dart';
import 'package:gogo/app/feature/home/model/restaurant_response_model.dart';

class RestaurantLoadMoreRepo extends LoadingMoreBase<Restaurant> {
  final HomeRepo repository;
  int currentPage = 1;
  final int pageSize;
  int totalPages = 1;
  bool _hasMore = true;
  bool forceRefresh = false;
  String searchTerm = "";

  RestaurantLoadMoreRepo({
    required this.repository,
    this.pageSize = 10,
  });

  void updateSearchTerm(String term) {
    searchTerm = term;
    refresh(true);
  }

  @override
  bool get hasMore => _hasMore || forceRefresh;

  @override
  Future<bool> refresh([bool clearBeforeRequest = false]) async {
    _hasMore = false;
    currentPage = 1;
    forceRefresh = !clearBeforeRequest;
    var result = await super.refresh(clearBeforeRequest);
    forceRefresh = false;
    return result;
  }

  @override
  Future<bool> loadData([bool isLoadMoreAction = false]) async {
    bool isSuccess = false;
    try {
      if (isLoadMoreAction && currentPage < totalPages) {
        currentPage++;
      }

      final params = {
        "page": currentPage,
        "limit": pageSize,
        if (searchTerm.isNotEmpty) "searchTerm": searchTerm,
      };

      final response = await repository.getAllResturentRepo(params);

      final dataMap = response.data as Map<String, dynamic>;
      final data = RestaurantResponse.fromJson(dataMap);
      final newRestaurants = data.data?.restaurants ?? [];

      totalPages = data.data?.totalPages ?? 1;

      if (newRestaurants.isEmpty) {
        _hasMore = false;
      }

      if (isLoadMoreAction) {
        addAll(newRestaurants);
      } else {
        clear();
        addAll(newRestaurants);
      }

      _hasMore = newRestaurants.length == pageSize && currentPage < totalPages;

      isSuccess = true;
    } catch (e, stack) {
      print('Error loading restaurants: $e');
      print(stack);
      isSuccess = false;
    }

    return isSuccess;
  }
}
