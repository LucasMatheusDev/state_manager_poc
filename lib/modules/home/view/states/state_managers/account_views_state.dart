import 'package:flutter/cupertino.dart';
import 'package:state_manager_poc/modules/home/view/states/account_views_state.dart';

class AccountViewsStateManager {
  final accountViews = ValueNotifier<AccountViewsState>(AccountViewsInitial());
}
