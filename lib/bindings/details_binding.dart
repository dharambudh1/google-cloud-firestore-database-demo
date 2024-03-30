import "package:firestore_database_demo/controllers/details_controller.dart";
import "package:get/get.dart";

class DetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(DetailsController.new);
  }
}
