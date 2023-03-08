abstract class AccountViewsState {}

class AccountViewsFailureState extends AccountViewsState {
  final String message;

  AccountViewsFailureState(this.message);
}

class AccountViewsSuccessState extends AccountViewsState {
  final int accountViews;

  AccountViewsSuccessState(this.accountViews);
}

class AccountViewsInitial extends AccountViewsState {}
