
import 'package:state_manager_poc/core/answer.dart';
import 'package:state_manager_poc/modules/home/model/entities/friend.dart';
import 'package:state_manager_poc/modules/home/model/exceptions/home_exception.dart';
import 'package:state_manager_poc/modules/home/model/repositories/friend_repository.dart';

class FriendViewModel{
  final FriendRepository _repository;

  FriendViewModel(this._repository);


  Future<Answer<HomeException, List<Friend>>> getFriends() async {
    return await _repository.getFriends();
  }

}