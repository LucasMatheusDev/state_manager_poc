import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:state_manager_poc/modules/home/view/states/action/home_action.dart';
import 'package:state_manager_poc/modules/home/view/states/home_state.dart';

class HomeStateManager {
  final _action = StreamController<HomeAction>.broadcast();

  final scaffoldKey = GlobalKey<ScaffoldState>();

  final postState = ValueNotifier<HomeState>(PostInitial());

  final friendState = ValueNotifier<HomeState>(FriendInitial());

  Stream<HomeAction> get action => _action.stream;

  void emitAction(HomeAction action) {
    log('emitAction: $action - ${DateTime.now()}', name: 'Home Action');
    _action.sink.add(action);
  }

  void setState(HomeState state) {
    if (state is PostState) {
      postState.value = state;
    } else if (state is FriendState) {
      friendState.value = state;
    }
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
        backgroundColor: Colors.red,
        content: Text(
          message,
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
