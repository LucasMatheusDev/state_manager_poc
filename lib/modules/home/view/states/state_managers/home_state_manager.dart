import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:state_manager_poc/core/register_events.dart';
import 'package:state_manager_poc/modules/home/view/states/account_views_state.dart';
import 'package:state_manager_poc/modules/home/view/states/action/home_action.dart';
import 'package:state_manager_poc/modules/home/view/states/home_state.dart';

class HomeStateManager {
  final _action = StreamController<HomeAction>.broadcast();

  final scaffoldKey = GlobalKey<ScaffoldState>();

  final postState = ValueNotifier<HomeState>(PostInitial());

  final friendState = ValueNotifier<HomeState>(FriendInitial());

  final accountViews = ValueNotifier<HomeState>(AccountViewsInitial());

  Stream<HomeAction> get action => _action.stream;

  final RegisterEvents _registerEvents;

  HomeStateManager({required RegisterEvents registerEvents})
      : _registerEvents = registerEvents {
    emitAction(HomeActionInstanceState());
  }

  void emitAction(HomeAction action) {
    log('emitAction: $action - ${DateTime.now()}', name: 'Home Action');
    registerAction(action);
    _action.sink.add(action);
  }

  void registerAction(HomeAction action) {
    _registerEvents.register(Event(name: 'Home Action', data: {
      'action': action.toString(),
      'time': DateTime.now(),
      'postState': postState.value.toString(),
      'friendState': friendState.value.toString(),
      'accountViews': accountViews.value.toString(),
      'scaffoldKey.currentContext': scaffoldKey.currentContext.toString(),
    }));
  }

  void setState(HomeState state) {
    if (state is PostState) {
      postState.value = state;
    } else if (state is FriendState) {
      friendState.value = state;
    } else if (state is AccountViewsState) {
      accountViews.value = state;
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

  void onDispose() {
    if (!_action.isClosed) {
      _action.close();
    }
  }
}
