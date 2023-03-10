import 'package:get/get.dart';
import 'package:state_manager_poc/modules/home/model/data/home_data_source.dart';
import 'package:state_manager_poc/modules/home/model/repositories/account_views_repository.dart';
import 'package:state_manager_poc/modules/home/model/repositories/home_repository.dart';
import 'package:state_manager_poc/modules/home/use_cases/account_views_use_case.dart';
import 'package:state_manager_poc/modules/home/use_cases/home_use_case.dart';
import 'package:state_manager_poc/modules/home/view/controllers/account_views_controller.dart';
import 'package:state_manager_poc/modules/home/view/controllers/home_controller.dart';
import 'package:state_manager_poc/modules/home/view/states/state_managers/home_state_manager.dart';

class HomeBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(HomeStateManager());

    Get.lazyPut(() => HomeDataSource());
    Get.lazyPut(() => HomeViewRepository(
          Get.find(),
        ));
    Get.lazyPut(() => HomeUseCase(Get.find()));
    Get.put(
      HomeController(
        stateManager: Get.find(),
        viewModel: Get.find(),
      ),
    );
    Get.lazyPut(() => AccountViewsUseCase());

    Get.lazyPut(() => FriendRepository(
          Get.find(),
        ));

    Get.put(AccountViewsController(
      viewModel: Get.find(),
      stateManager: Get.find(),
    ));
  }
}
