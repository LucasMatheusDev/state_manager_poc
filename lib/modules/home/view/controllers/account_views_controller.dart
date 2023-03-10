import 'package:state_manager_poc/core/answer.dart';
import 'package:state_manager_poc/modules/home/view/states/account_views_state.dart';
import 'package:state_manager_poc/modules/home/view/states/action/home_action.dart';
import 'package:state_manager_poc/modules/home/view/states/state_managers/home_state_manager.dart';
import 'package:state_manager_poc/modules/home/view_model/account_views_view_model.dart';

class AccountViewsController {
  final AccountViewsViewModel _viewModel;
  final HomeStateManager _stateManager;

  AccountViewsController({
    required AccountViewsViewModel viewModel,
    required HomeStateManager stateManager,
  })  : _viewModel = viewModel,
        _stateManager = stateManager {
    stateManager.action.listen((action) {
      if (action is HomeActionInitState) {
        getAccountViews();
      }
    });
  }

  Future<void> getAccountViews() async {
    final viewsAnswer = await _viewModel.getAccountViews();

    if (viewsAnswer is Success) {
      final views = viewsAnswer.asSuccess;
      _stateManager.setState(AccountViewsSuccessState(views));
    } else {
      final exception = viewsAnswer.asFailure;
      _stateManager.setState(AccountViewsFailureState(exception.message));
    }
  }
}
