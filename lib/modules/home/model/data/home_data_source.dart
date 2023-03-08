import 'package:faker/faker.dart';
import 'package:state_manager_poc/modules/home/model/entities/friend.dart';
import 'package:state_manager_poc/modules/home/model/entities/post.dart';
import 'package:state_manager_poc/modules/home/model/exceptions/rest_client_exception.dart';

class HomeDataSource {
  Future<List<Post>> getPosts() async {
    final probabilityResponses = [
      'success',
      'error',
      'success',
      'notFound',
      'success'
    ];
    probabilityResponses.shuffle();
    final String response = probabilityResponses.first;
    await Future.delayed(const Duration(seconds: 2));

    if (response == 'success') {
      return List.generate(
        10,
        (index) => Post(
          title: faker.lorem.sentence(),
          description: faker.lorem.sentence(),
          imageUrl: 'https://picsum.photos/200/300?random=$index',
        ),
      );
    } else if (response == 'notFound') {
      throw RestClientException(
        message: 'Not Found posts',
        code: 404,
      );
    } else {
      throw RestClientException(
        message: 'Internal Server Error',
        code: 500,
      );
    }
  }

  Future<List<Friend>> getFriends() async {
    final probabilityResponses = [
      'success',
      'error',
      'success',
      'notFound',
      'success'
    ];
    probabilityResponses.shuffle();
    final String response = probabilityResponses.first;
    await Future.delayed(const Duration(seconds: 4));

    if (response == 'success') {
      return List.generate(
        10,
        (index) => Friend(
          name: faker.person.name(),
          imageUrl: 'https://picsum.photos/200/300?random=$index',
        ),
      );
    } else if (response == 'notFound') {
      throw RestClientException(
        message: 'Not Found friends',
        code: 404,
      );
    } else {
      throw RestClientException(
        message: 'Internal Server Error',
        code: 500,
      );
    }
  }

  Future<int> getAccountViews() async {
    final probabilityResponses = [
      'success',
      'error',
      'success',
      'notFound',
      'success'
    ];
    probabilityResponses.shuffle();
    final String response = probabilityResponses.first;
    await Future.delayed(const Duration(seconds: 7));

    if (response == 'success') {
      return faker.randomGenerator.integer(100000, min: 1000);
    } else if (response == 'notFound') {
      throw RestClientException(
        message: 'Not Found account views',
        code: 404,
      );
    } else {
      throw RestClientException(
        message: 'Internal Server Error',
        code: 500,
      );
    }
  }
}
