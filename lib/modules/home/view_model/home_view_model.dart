import 'package:state_manager_poc/core/answer.dart';
import 'package:state_manager_poc/modules/home/model/entities/post.dart';
import 'package:state_manager_poc/modules/home/model/exceptions/home_exception.dart';
import 'package:state_manager_poc/modules/home/model/repositories/account_view_repository.dart';

class HomeViewModel {
  final HomeViewRepository _repository;

  HomeViewModel(this._repository);

  Future<Answer<HomeException, int>> getAccountViews() async {
    return await _repository.getAccountViews();
  }

  Future<Answer<HomeException, List<Post>>> getPosts() async {
    return await _repository.getPosts();
  }
}
