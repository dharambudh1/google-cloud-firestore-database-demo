import "package:firestore_database_demo/bindings/details_binding.dart";
import "package:firestore_database_demo/bindings/home_binding.dart";
import "package:firestore_database_demo/screens/details_screen.dart";
import "package:firestore_database_demo/screens/home_screen.dart";
import "package:get/get.dart";

class AppRoutes {
  AppRoutes._();
  static final AppRoutes instance = AppRoutes._();

  String get homeScreen => "/";
  String get detailsScreen => "/detailsScreen";

  List<GetPage<dynamic>> get getPages {
    final GetPage<dynamic> homeScreenPage = GetPage<dynamic>(
      name: homeScreen,
      page: HomeScreen.new,
      binding: HomeBinding(),
    );

    final GetPage<dynamic> detailsScreenPage = GetPage<dynamic>(
      name: detailsScreen,
      page: DetailsScreen.new,
      binding: DetailsBinding(),
    );

    return <GetPage<dynamic>>[homeScreenPage, detailsScreenPage];
  }
}
