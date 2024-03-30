import "dart:convert";

import "package:flutter/widgets.dart";
import "package:get/get.dart";

class DetailsController extends GetxController {
  RxString itemId = "".obs;
  RxMap<String, dynamic> itemData = <String, dynamic>{}.obs;
  final TextEditingController textEditingController = TextEditingController();

  @override
  void onInit() {
    super.onInit();

    if (Get.parameters.isNotEmpty) {
      itemId(Get.parameters["id"] ?? "");
      itemData(json.decode(Get.parameters["data"] ?? ""));
      textEditingController.text = itemData["text"] ?? "";
    } else {}
  }

  @override
  void onClose() {
    itemId.close();
    itemData.close();
    textEditingController.dispose();
    super.onClose();
  }
}
