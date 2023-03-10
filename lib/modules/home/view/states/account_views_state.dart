import 'package:state_manager_poc/modules/home/view/states/home_state.dart';

abstract class AccountViewsState  extends HomeState{}

class AccountViewsFailureState extends AccountViewsState {
  final String message;

  AccountViewsFailureState(this.message);
}

class AccountViewsSuccessState extends AccountViewsState {
  final int accountViews;

  AccountViewsSuccessState(this.accountViews);
}

class AccountViewsInitial extends AccountViewsState {}
