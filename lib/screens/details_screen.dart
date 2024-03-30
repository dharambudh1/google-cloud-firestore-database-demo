import "package:firestore_database_demo/controllers/details_controller.dart";
import "package:firestore_database_demo/singleton/database_singleton.dart";
import "package:firestore_database_demo/util/app_snackbar.dart";
import "package:flutter/material.dart";
import "package:get/get.dart";

class DetailsScreen extends GetView<DetailsController> {
  const DetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(controller.itemId.value == "" ? "Add note" : "Update note"),
        actions: <Widget>[
          Visibility(
            visible: controller.itemId.value != "",
            child: IconButton(
              icon: const Icon(Icons.delete_forever_outlined),
              onPressed: () async {
                await DatabaseSingleton.instance.deleteNote(
                  id: controller.itemId.value,
                  successCallback: AppSnackbar.instance.snackbar,
                  failureCallback: AppSnackbar.instance.snackbar,
                );
                Get.key.currentState?.pop();
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.save),
        onPressed: () async {
          controller.itemId.value == ""
              ? await DatabaseSingleton.instance.addNote(
                  text: controller.textEditingController.value.text,
                  successCallback: AppSnackbar.instance.snackbar,
                  failureCallback: AppSnackbar.instance.snackbar,
                )
              : await DatabaseSingleton.instance.updateNote(
                  id: controller.itemId.value,
                  text: controller.textEditingController.value.text,
                  successCallback: AppSnackbar.instance.snackbar,
                  failureCallback: AppSnackbar.instance.snackbar,
                );
          Get.key.currentState?.pop();
        },
      ),
      body: SafeArea(
        child: padding(),
      ),
    );
  }

  Widget padding() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: textField(),
    );
  }

  Widget textField() {
    return TextField(
      controller: controller.textEditingController,
      maxLines: 10,
      keyboardType: TextInputType.multiline,
      decoration: const InputDecoration(
        hintText: "Write something...",
        border: OutlineInputBorder(),
      ),
    );
  }
}
