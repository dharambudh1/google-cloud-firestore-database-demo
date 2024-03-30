import "package:get/get.dart";

class AppSnackbar {
  AppSnackbar._();
  static final AppSnackbar instance = AppSnackbar._();

  void snackbar(String message) {
    final String msg = message;
    const Duration dur = Duration(seconds: 4);
    final GetSnackBar snackbar = GetSnackBar(message: msg, duration: dur);
    Get.showSnackbar(snackbar);
    return;
  }
}
