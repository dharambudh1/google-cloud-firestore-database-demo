import "dart:developer";

import "package:cloud_firestore/cloud_firestore.dart";
import "package:firestore_database_demo/singleton/database_singleton.dart";
import "package:get/get.dart";

class HomeController extends GetxController {
  final Rx<Stream<QuerySnapshot<dynamic>>> rxStream =
      const Stream<QuerySnapshot<dynamic>>.empty().obs;

  @override
  void onInit() {
    super.onInit();
    
    rxStream(
      DatabaseSingleton.instance.readNotes(
        successCallback: (String message) {
          log("HomeController:: onInit():: successCallback:: $message");
        },
        failureCallback: (String message) {
          log("HomeController:: onInit():: failureCallback:: $message");
        },
      ),
    );
  }

  @override
  void onClose() {
    rxStream.close();
    super.onClose();
  }

  QueryDocumentSnapshot<dynamic>? getListItem({
    required QuerySnapshot<dynamic>? snapshotData,
    required int index,
  }) {
    return snapshotData?.docs[index];
  }

  String getId({required QueryDocumentSnapshot<dynamic>? docsData}) {
    return docsData?.id ?? "";
  }

  Map<String, dynamic> getData({
    required QueryDocumentSnapshot<dynamic>? docsData,
  }) {
    return docsData?.data() ?? <String, dynamic>{};
  }
}
