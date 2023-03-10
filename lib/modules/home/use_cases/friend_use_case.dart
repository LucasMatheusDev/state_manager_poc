import 'package:faker/faker.dart';
import 'package:state_manager_poc/core/answer.dart';
import 'package:state_manager_poc/modules/home/model/entities/friend.dart';
import 'package:state_manager_poc/modules/home/model/exceptions/home_exception.dart';

class FriendUseCase {
  Future<Answer<HomeException, List<Friend>>> getFriends() async {
    return await fetchFriends();
  }

  final probabilityResponses = [
    'success',
    'error',
    'success',
    'notFound',
    'success'
  ];

  Future<Answer<HomeException, List<Friend>>> fetchFriends() async {
    //
    // Shuffle to simulate a external service random response
    probabilityResponses.shuffle();
    final String response = probabilityResponses.first;

    await Future.delayed(const Duration(seconds: 4));

    if (response == 'success') {
      return Success(
        List.generate(
          10,
          (index) => Friend(
            name: faker.person.name(),
            imageUrl: 'https://picsum.photos/200/300?person=$index',
          ),
        ),
      );
    } else if (response == 'notFound') {
      return Failure(
        FriendNotFoundException(
          message: 'Not Found friends',
          code: 404,
        ),
      );
    } else {
      return Failure(
        FriendDefaultException(
          message: 'Internal Server Error',
          code: 500,
        ),
      );
    }
  }
}
