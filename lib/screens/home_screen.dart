import "dart:convert";

import "package:cloud_firestore/cloud_firestore.dart";
import "package:firestore_database_demo/controllers/home_controller.dart";
import "package:firestore_database_demo/util/app_routes.dart";
import "package:flutter/material.dart";
import "package:get/get.dart";

class HomeScreen extends GetView<HomeController> {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Firestore Database")),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () async {
          await Get.toNamed(AppRoutes.instance.detailsScreen);
        },
      ),
      body: SafeArea(
        child: streamBuilder(),
      ),
    );
  }

  Widget streamBuilder() {
    return StreamBuilder<QuerySnapshot<dynamic>>(
      stream: controller.rxStream.value,
      builder: (
        BuildContext context,
        AsyncSnapshot<QuerySnapshot<dynamic>> snapshot,
      ) {
        return listViewBuilder(snapshotData: snapshot.data);
      },
    );
  }

  Widget listViewBuilder({required QuerySnapshot<dynamic>? snapshotData}) {
    return (snapshotData?.docs.isEmpty ?? true)
        ? const Center(
            child: Text("No notes found, try adding a new note."),
          )
        : ListView.builder(
            itemCount: snapshotData?.docs.length ?? 0,
            itemBuilder: (
              BuildContext context,
              int index,
            ) {
              final QueryDocumentSnapshot<dynamic>? item =
                  controller.getListItem(
                snapshotData: snapshotData,
                index: index,
              );
              return listViewAdapter(docsData: item);
            },
          );
  }

  Widget listViewAdapter({required QueryDocumentSnapshot<dynamic>? docsData}) {
    final String id = controller.getId(docsData: docsData);
    final Map<String, dynamic> data = controller.getData(docsData: docsData);
    final String text = data["text"] ?? "";
    return ListTile(
      dense: true,
      title: Text(text),
      subtitle: Text("ID: $id"),
      leading: const Icon(Icons.sticky_note_2_outlined),
      trailing: const Icon(Icons.edit_outlined),
      onTap: () async {
        await Get.toNamed(
          AppRoutes.instance.detailsScreen,
          parameters: <String, String>{"id": id, "data": json.encode(data)},
        );
      },
    );
  }
}
