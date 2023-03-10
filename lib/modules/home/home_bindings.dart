import 'package:get/get.dart';
import 'package:state_manager_poc/core/register_events.dart';
import 'package:state_manager_poc/modules/home/use_cases/account_views_use_case.dart';
import 'package:state_manager_poc/modules/home/use_cases/friend_use_case.dart';
import 'package:state_manager_poc/modules/home/use_cases/home_use_case.dart';
import 'package:state_manager_poc/modules/home/view/controllers/account_views_controller.dart';
import 'package:state_manager_poc/modules/home/view/controllers/friend_controller.dart';
import 'package:state_manager_poc/modules/home/view/controllers/home_controller.dart';
import 'package:state_manager_poc/modules/home/view/states/state_managers/home_state_manager.dart';

class HomeBindings extends Bindings {
  @override
  void dependencies() {
    // Create a permanent instance of RegisterEvents
    Get.put(RegisterEvents(), permanent: true);

    Get.put(
      HomeStateManager(
        registerEvents: Get.find(),
      ),
    );

    Get.lazyPut(() => HomeUseCase());
    Get.put(
      HomeController(
        stateManager: Get.find(),
        viewModel: Get.find(),
      ),
    );
    Get.lazyPut(() => AccountViewsUseCase());

    Get.put(AccountViewsController(
      viewModel: Get.find(),
      stateManager: Get.find(),
    ));

    Get.lazyPut(() => FriendUseCase());

    Get.put(FriendController(
      viewModel: Get.find(),
      stateManager: Get.find(),
    ));
  }
}
