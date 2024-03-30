import "package:firestore_database_demo/controllers/home_controller.dart";
import "package:get/get.dart";

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(HomeController.new);
  }
}
