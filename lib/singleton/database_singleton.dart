import "dart:developer";

import "package:cloud_firestore/cloud_firestore.dart";

class DatabaseSingleton {
  DatabaseSingleton._();
  static final DatabaseSingleton instance = DatabaseSingleton._();

  final FirebaseFirestore firestoreInstance = FirebaseFirestore.instance;
  final CollectionReference<dynamic> collectionReference =
      FirebaseFirestore.instance.collection("notes");

  Stream<QuerySnapshot<dynamic>> readNotes({
    required Function(String message) successCallback,
    required Function(String message) failureCallback,
  }) {
    Stream<QuerySnapshot<dynamic>> stream =
        const Stream<QuerySnapshot<dynamic>>.empty();
    try {
      stream = collectionReference.snapshots();
      successCallback("Records fetched successfully.");
    } on Exception catch (error) {
      log("DatabaseSingleton:: readNotes():: Exception caught:: $error");
      failureCallback("Records not fetched.");
    } finally {}
    return stream;
  }

  Future<void> addNote({
    required String text,
    required Function(String message) successCallback,
    required Function(String message) failureCallback,
  }) async {
    try {
      final DocumentReference<dynamic> result = await collectionReference.add(
        <String, dynamic>{"text": text},
      );
      log("DatabaseSingleton:: addNote():: result.id:: ${result.id}");
      successCallback("Note added successfully.");
    } on Exception catch (error) {
      log("DatabaseSingleton:: addNote():: Exception caught:: $error");
      failureCallback("Note not added.");
    } finally {}
    return Future<void>.value();
  }

  Future<void> updateNote({
    required String id,
    required String text,
    required Function(String message) successCallback,
    required Function(String message) failureCallback,
  }) async {
    try {
      final DocumentReference<dynamic> result = collectionReference.doc(id);
      await result.update(<String, dynamic>{"text": text});
      successCallback("Note updated successfully.");
    } on Exception catch (error) {
      log("DatabaseSingleton:: updateNote():: Exception caught:: $error");
      failureCallback("Note not updated.");
    } finally {}
    return Future<void>.value();
  }

  Future<void> deleteNote({
    required String id,
    required Function(String message) successCallback,
    required Function(String message) failureCallback,
  }) async {
    try {
      final DocumentReference<dynamic> result = collectionReference.doc(id);
      await result.delete();
      successCallback("Note deleted successfully.");
    } on Exception catch (error) {
      log("DatabaseSingleton:: deleteNote():: Exception caught:: $error");
      failureCallback("Note not deleted.");
    } finally {}
    return Future<void>.value();
  }
}
