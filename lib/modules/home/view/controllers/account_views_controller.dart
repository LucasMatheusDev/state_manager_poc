
// class AccountViewsController {
//   final AccountViewsViewModel _viewModel;
//   final AccountViewsStateManager _stateManager;

//   AccountViewsController({
//     required AccountViewsViewModel viewModel,
//     required AccountViewsStateManager stateManager,
//   })  : _viewModel = viewModel,
//         _stateManager = stateManager;

//   Future<void> getAccountViews() async {
//     final viewsAnswer = await _viewModel.getAccountViews();

//     if (viewsAnswer is Success) {
//       final views = viewsAnswer.asSuccess;
//       _stateManager.setState(AccountViewsSuccessState(views));
//     } else {
//       final exception = viewsAnswer.asFailure;
//       _stateManager.setState(AccountViewsFailureState(exception.message));
//     }
//   }
// }
