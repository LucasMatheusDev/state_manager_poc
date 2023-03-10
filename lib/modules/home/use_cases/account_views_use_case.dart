import 'package:faker/faker.dart';
import 'package:state_manager_poc/core/answer.dart';
import 'package:state_manager_poc/modules/home/model/exceptions/home_exception.dart';

class AccountViewsUseCase {
  Future<Answer<HomeException, int>> getAccountViews() async {
    return await fetchAccountViews();
  }
}

final probabilityResponses = [
  'success',
  'error',
  'success',
  'notFound',
  'success'
];

// Example of External service
Future<Answer<HomeException, int>> fetchAccountViews() async {
  //
  // Shuffle to simulate a external service random response
  probabilityResponses.shuffle();
  final String response = probabilityResponses.first;

  // high Delay to simulate a external service slow call
  await Future.delayed(const Duration(seconds: 7));

  if (response == 'success') {
    return Success(
      faker.randomGenerator.integer(100000, min: 1000),
    );
  } else if (response == 'notFound') {
    return Failure(
      AccountViewDefaultException(
        message: 'Not Found friends',
        code: 404,
      ),
    );
  } else {
    return Failure(
      AccountViewDefaultException(
        message: 'Internal Server Error',
        code: 500,
      ),
    );
  }
}
