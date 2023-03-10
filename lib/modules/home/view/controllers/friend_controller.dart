import 'package:state_manager_poc/modules/home/model/exceptions/home_exception.dart';
import 'package:state_manager_poc/modules/home/use_cases/friend_use_case.dart';
import 'package:state_manager_poc/modules/home/view/states/action/home_action.dart';
import 'package:state_manager_poc/modules/home/view/states/home_state.dart';
import 'package:state_manager_poc/modules/home/view/states/state_managers/home_state_manager.dart';

class FriendController {
  final HomeStateManager _stateManager;
  final FriendUseCase _viewModel;

  FriendController({
    required HomeStateManager stateManager,
    required FriendUseCase viewModel,
  })  : _viewModel = viewModel,
        _stateManager = stateManager {
    initListenAction();
  }

  void initListenAction() {
    _stateManager.action.listen((action) {
      if (action is HomeActionInitState) {
        getFriends();
      }
    });
  }

  Future<void> getFriends() async {
    _stateManager.setState(FriendLoadingState());
    final friendsAnswer = await _viewModel.getFriends();
    friendsAnswer.deal(
      onSuccess: (friends) => _stateManager.setState(
        FriendSuccessState(friends),
      ),
      onFail: (exception) {
        if (exception is FriendNotFoundException) {
          _stateManager.setState(
            FriendsNotFoundState(exception.message),
          );
        } else {
          _stateManager.setState(
            FriendFailureState(exception.message),
          );
        }
      },
    );
  }
}
