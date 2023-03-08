import 'package:state_manager_poc/core/answer.dart';
import 'package:state_manager_poc/modules/home/model/exceptions/home_exception.dart';
import 'package:state_manager_poc/modules/home/model/repositories/account_views_repository.dart';

class AccountViewsViewModel {
  final FriendRepository _repository;

  AccountViewsViewModel(this._repository);

  Future<Answer<HomeException, int>> getAccountViews() async {
    return await _repository.getAccountViews();
  }
}
