import 'dart:async';

import 'package:flutter/material.dart';
import 'package:state_manager_poc/modules/home/view/states/account_views_state.dart';
import 'package:state_manager_poc/modules/home/view/states/action/home_action.dart';
import 'package:state_manager_poc/modules/home/view/states/home_state.dart';

class HomeStateManager {
  final _action = StreamController<HomeStateAction>.broadcast();

  final scaffoldKey = GlobalKey<ScaffoldState>();

  final postState = ValueNotifier<HomeState>(PostInitial());

  final friendState = ValueNotifier<HomeState>(FriendInitial());

  final accountViews =
      ValueNotifier<AccountViewState?>(AccountViewState.initial);

  Stream<HomeStateAction> get action => _action.stream;

  void emitAction(HomeStateAction action) {
    _action.sink.add(action);
  }

  void showSnackBar(String message) {
    if (scaffoldKey.currentContext == null) {
      return;
    }
    ScaffoldMessenger.of(scaffoldKey.currentContext!).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  void showSnackBarRequestLogin(String message) {
    if (scaffoldKey.currentContext == null) {
      return;
    }
    ScaffoldMessenger.of(scaffoldKey.currentContext!).showSnackBar(
      SnackBar(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        backgroundColor: Colors.red,
        content: Text(
          message,
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
