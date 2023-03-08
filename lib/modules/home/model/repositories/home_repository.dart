import 'package:state_manager_poc/core/answer.dart';
import 'package:state_manager_poc/modules/home/model/data/home_data_source.dart';
import 'package:state_manager_poc/modules/home/model/entities/friend.dart';
import 'package:state_manager_poc/modules/home/model/entities/post.dart';
import 'package:state_manager_poc/modules/home/model/exceptions/home_exception.dart';
import 'package:state_manager_poc/modules/home/model/exceptions/rest_client_exception.dart';

class HomeViewRepository {
  final HomeDataSource _dataSource;

  HomeViewRepository(this._dataSource);


  Future<Answer<HomeException, List<Post>>> getPosts() async {
    try {
      final posts = await _dataSource.getPosts();
      return Success(posts);
    } on RestClientException catch (e) {
      if (e.code == 404) {
        return Failure(PostNotFoundException(
          message: e.message,
          code: e.code,
        ));
      } else {
        return Failure(PostDefaultException(
          message: e.message,
          code: e.code,
        ));
      }
    }
  }


  Future<Answer<HomeException, List<Friend>>> getFriends() async {
    try {
      final friends = await _dataSource.getFriends();
      return Success(friends);
    } on RestClientException catch (e) {
      if (e.code == 404) {
        return Failure(FriendNotFoundException(
          message: e.message,
          code: e.code,
        ));
      } else {
        return Failure(FriendDefaultException(
          message: e.message,
          code: e.code,
        ));
      }
    }
  }
}
