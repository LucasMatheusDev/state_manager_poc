import 'package:get/get.dart';
import 'package:state_manager_poc/modules/home/model/data/home_data_source.dart';
import 'package:state_manager_poc/modules/home/model/repositories/home_repository.dart';
import 'package:state_manager_poc/modules/home/view/controllers/home_controller.dart';
import 'package:state_manager_poc/modules/home/view/states/state_managers/home_state_manager.dart';
import 'package:state_manager_poc/modules/home/view_model/home_view_model.dart';

class HomeBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(HomeStateManager());
    Get.put(HomeDataSource());
    Get.put(HomeViewRepository(
      Get.find(),
    ));
    Get.put(HomeViewModel(Get.find()));
    Get.put(
      HomeController(
        stateManager: Get.find(),
        viewModel: Get.find(),
      ),
    );
  }
}
