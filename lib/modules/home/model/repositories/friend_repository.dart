import 'package:state_manager_poc/core/answer.dart';
import 'package:state_manager_poc/modules/home/model/data/home_data_source.dart';
import 'package:state_manager_poc/modules/home/model/entities/friend.dart';
import 'package:state_manager_poc/modules/home/model/exceptions/home_exception.dart';
import 'package:state_manager_poc/modules/home/model/exceptions/rest_client_exception.dart';

class FriendRepository {
  final HomeDataSource _dataSource;

  FriendRepository(this._dataSource);

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
