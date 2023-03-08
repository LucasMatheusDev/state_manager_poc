import 'package:state_manager_poc/core/answer.dart';
import 'package:state_manager_poc/modules/home/model/data/home_data_source.dart';
import 'package:state_manager_poc/modules/home/model/exceptions/home_exception.dart';
import 'package:state_manager_poc/modules/home/model/exceptions/rest_client_exception.dart';

class FriendRepository {
  final HomeDataSource _dataSource;

  FriendRepository(this._dataSource);

  Future<Answer<HomeException, int>> getAccountViews() async {
    try {
      final views = await _dataSource.getAccountViews();
      return Success(views);
    } on RestClientException catch (e) {
      return Failure(AccountViewDefaultException(
        message: e.message,
        code: e.code,
      ));
    }
  }
}
