import 'package:get/get.dart';
import 'package:state_manager_poc/modules/home/use_cases/account_views_use_case.dart';
import 'package:state_manager_poc/modules/home/use_cases/home_use_case.dart';
import 'package:state_manager_poc/modules/home/view/controllers/account_views_controller.dart';
import 'package:state_manager_poc/modules/home/view/controllers/home_controller.dart';
import 'package:state_manager_poc/modules/home/view/states/state_managers/home_state_manager.dart';

class HomeBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(HomeStateManager());

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
  }
}
