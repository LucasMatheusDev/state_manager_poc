import 'package:state_manager_poc/core/answer.dart';
import 'package:state_manager_poc/modules/home/model/entities/friend.dart';
import 'package:state_manager_poc/modules/home/model/entities/post.dart';
import 'package:state_manager_poc/modules/home/model/exceptions/home_exception.dart';
import 'package:state_manager_poc/modules/home/model/repositories/home_repository.dart';

class HomeUseCase {
  final HomeViewRepository _repository;

  HomeUseCase(this._repository);

  Future<Answer<HomeException, List<Friend>>> getFriends() async {
    return await _repository.getFriends();
  }

  Future<Answer<HomeException, List<Post>>> getPosts() async {
    return await _repository.getPosts();
  }
}
